import 'dart:developer' show log;
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:news_demo/core/core.dart';
import 'package:news_demo/src/home/data/model/article.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const kDbName = 'news_db';
const kArticleTableName = 'Articles';
const kCacheMetaData = 'CacheMetaData';

abstract class HomeLocalDatasource {
  EitherFutureData<List<Article>> fetchArticles({
    String? query,
    int pageSize = 15,
    int page = 0,
  });

  Future<int> fetchArticlesCount();

  EitherFutureData<void> insertArticles(List<Article> articles);

  EitherFutureData<List<Article>> fetchFavourites();

  EitherFutureData<Article> toggleFavourite(Article article);
}

const _dbName = 'news_db.db';
const _articleTable = 'Articles';
const _cacheMetaTable = 'CacheMetaData';
const _cacheDurationInHours = 24;

@Injectable(as: HomeLocalDatasource)
class HomeLocalDatasourceImpl extends HomeLocalDatasource {
  static Database? _db;

  HomeLocalDatasourceImpl();

  Future<Database> get _database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), _dbName);
    if (kDebugMode) log('DB path: $path');

    return openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: (db, oldV, newV) async {
        if (oldV < 2) {
          await db.execute(
            'ALTER TABLE $_articleTable ADD COLUMN lastUpdated INTEGER',
          );
          await db.execute('''
            CREATE TABLE IF NOT EXISTS $_cacheMetaTable (
              tableName TEXT PRIMARY KEY,
              lastUpdated INTEGER
            )''');
        }
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_articleTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        author TEXT,
        title TEXT,
        description TEXT,
        url TEXT,
        urlToImage TEXT,
        publishedAt TEXT,
        content TEXT,
        isFavourite INTEGER NOT NULL DEFAULT 0,
        lastUpdated INTEGER,
        UNIQUE(url, publishedAt)
      )''');

    await db.execute('''
      CREATE TABLE $_cacheMetaTable (
        tableName TEXT PRIMARY KEY,
        lastUpdated INTEGER
      )''');
  }

  @override
  EitherFutureData<void> insertArticles(List<Article> articles) async {
    try {
      final db = await _database;
      await db.transaction((txn) async {
        final batch = txn.batch();
        final now = DateTime.now().toUtc().millisecondsSinceEpoch;
        for (final a in articles) {
          final json = a.toJson()..removeEmptyValues();
          json['lastUpdated'] = now;
          json['isFavourite'] = a.isFavourite == true ? 1 : 0;
          batch.insert(
            _articleTable,
            json,
            conflictAlgorithm: ConflictAlgorithm.ignore,
          );
        }
        await batch.commit(noResult: true);
      });
      return right(null);
    } catch (e) {
      return left(ExceptionHandler.instance.parseError(e));
    }
  }

  @override
  EitherFutureData<List<Article>> fetchArticles({
    String? query,
    int pageSize = 10,
    int page = 0,
  }) async {
    try {
      final db = await _database;
      await _cleanupExpiredTasks(db);
      final offset = page * pageSize;
      final whereCl =
          (query?.trim().isNotEmpty ?? false)
              ? 'WHERE title LIKE ? OR description LIKE ? OR content LIKE ?'
              : '';
      final args =
          query?.trim().isNotEmpty ?? false
              ? List.filled(3, '%${query!.trim()}%')
              : <String>[];

      final results = await db.rawQuery(
        '''
        SELECT * FROM $_articleTable
        $whereCl
        ORDER BY publishedAt DESC
        LIMIT ? OFFSET ?
        ''',
        [...args, pageSize, offset],
      );

      final articles = await Isolate.run<List<Article>>(() {
        return results.map((e) {
          return Article.fromJson(
            e,
          ).copyWith(isFavourite: (e['isFavourite'] as int) == 1);
        }).toList();
      });

      log('articles from db => ${articles.length}');
      return right(articles);
    } catch (e) {
      return left(ExceptionHandler.instance.parseError(e));
    }
  }

  @override
  EitherFutureData<List<Article>> fetchFavourites() async {
    try {
      final db = await _database;
      await _cleanupExpiredTasks(db);
      final results = await db.query(
        _articleTable,
        where: 'isFavourite = ?',
        whereArgs: [1],
      );
      final articles = await Isolate.run<List<Article>>(() {
        return results.map((e) {
          return Article.fromJson(
            e,
          ).copyWith(isFavourite: (e['isFavourite'] as int) == 1);
        }).toList();
      });
      return right(articles);
    } catch (e) {
      return left(ExceptionHandler.instance.parseError(e));
    }
  }

  @override
  Future<int> fetchArticlesCount() async {
    try {
      final db = await _database;
      await _cleanupExpiredTasks(db);
      final result = await db.rawQuery(
        'SELECT COUNT(*) FROM $kArticleTableName',
      );
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      return -1;
    }
  }

  @override
  EitherFutureData<Article> toggleFavourite(Article article) async {
    try {
      final db = await _database;

      final count = await db.rawUpdate(
        '''
          UPDATE $kArticleTableName
          SET isFavourite = ((isFavourite | 1) - (isFavourite & 1))
          WHERE url = ? AND publishedAt = ?
      ''',
        [article.url, article.publishedAt],
      );

      if (count == 0) throw LocalDatabaseException('No article updated');

      final results = await db.query(
        kArticleTableName,
        where: 'url = ? AND publishedAt = ?',
        whereArgs: [article.url, article.publishedAt],
      );

      if (results.isEmpty) {
        throw LocalDatabaseException('Article not found');
      }

      final updatedArticle = Article.fromJson(
        results.firstOrNull ?? {},
      ).copyWith(
        isFavourite: (results.firstOrNull?['isFavourite'] as int) == 1,
      );

      return right(updatedArticle);
    } catch (e) {
      return left(ExceptionHandler.instance.parseError(e));
    }
  }
}

/// Invalidate per-article cache older than threshold.
Future<void> _cleanupExpiredTasks(Database db) async {
  final threshold =
      DateTime.now()
          .toUtc()
          .subtract(const Duration(hours: _cacheDurationInHours))
          .millisecondsSinceEpoch;
  await db.delete(
    _articleTable,
    where: 'lastUpdated < ?',
    whereArgs: [threshold],
  );
}
