import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_demo/core/core.dart';
import 'package:news_demo/core/model/app_response/app_response.dart';
import 'package:news_demo/src/home/data/datasource/home_local_datasource.dart';
import 'package:news_demo/src/home/data/datasource/home_remote_datasource.dart';
import 'package:news_demo/src/home/data/model/article.dart';

abstract class HomeRepository {
  EitherFutureData<AppResponse<Article>> fetchArticles({
    String? query,
    int? pageSize,
    int page = 1,
  });

  EitherFutureData<List<Article>> fetchBookMarks();

  EitherFutureData<Article> updateBookMark(Article article);
}

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  HomeRepositoryImpl({
    required HomeLocalDatasource localSource,
    required HomeRemoteDataSource remoteSource,
  }) : _localSource = localSource,
       _remoteSource = remoteSource;

  final HomeLocalDatasource _localSource;
  final HomeRemoteDataSource _remoteSource;

  @override
  EitherFutureData<AppResponse<Article>> fetchArticles({
    String? query,
    int? pageSize,
    int page = 1,
  }) async {
    final hasConnection = await sl<InternetConnectionChecker>().hasConnection;

    if (hasConnection) {
      final results = await _remoteSource.fetchArticles(
        query: query,
        page: page,
        pageSize: pageSize,
      );

      if (results.isLeft()) {
        return left(
          results.getLeft().getOrElse(
            () => ServerException('Unknown error occurred'),
          ),
        );
      }

      final articles = results.getRight().getOrElse(
        () => AppResponse.initial(),
      );

      await _localSource.insertArticles(articles.results);

      return right(articles);
    }

    final totalResult = await _localSource.fetchArticlesCount(query);

    final results = await _localSource.fetchArticles(
      query: query,
      page: page - 1, // removing 1 because the local pagination starts from 0
      pageSize: pageSize ?? 10,
    );

    return results.fold(
      (l) => left(l),
      (r) => right(
        AppResponse<Article>.initial().copyWith(
          totalResults: totalResult,
          results: r,
        ),
      ),
    );
  }

  @override
  EitherFutureData<List<Article>> fetchBookMarks() async {
    try {
      final results = await _localSource.fetchFavourites();
      return results.fold((l) => left(l), (r) => right(r));
    } catch (e) {
      return left(ExceptionHandler.instance.parseError(e));
    }
  }

  @override
  EitherFutureData<Article> updateBookMark(Article article) async {
    try {
      final result = await _localSource.toggleFavourite(article);
      return result.fold((l) => left(l), (r) => right(r));
    } catch (e) {
      return left(ExceptionHandler.instance.parseError(e));
    }
  }
}
