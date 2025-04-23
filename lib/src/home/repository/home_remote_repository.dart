import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:news_demo/core/core.dart';
import 'package:news_demo/core/model/app_response/app_response.dart';
import 'package:news_demo/src/home/model/article.dart';

enum ArticleSort {
  relevancy('Relevance', 'relevancy'),
  popularity('Popularity', 'popularity'),
  publishedAt('Recently Published', 'publishedAt');

  const ArticleSort(this.name, this.value);
  final String name;
  final String value;
}

abstract class HomeRemoteRepository {
  EitherFutureData<AppResponse<Article>> fetchArticles({
    String? query,
    ArticleSort? sort,
    int? pageSize,
    int page = 1,
  });
}

@Injectable(as: HomeRemoteRepository)
class HomeRemoteRepositoryImpl extends HomeRemoteRepository {
  final RemoteService _networkService = sl<RemoteService>();
  @override
  EitherFutureData<AppResponse<Article>> fetchArticles({
    String? query,
    ArticleSort? sort,
    int? pageSize,
    int page = 1,
  }) async {
    final queryParam = {
      'q': query,
      'sortBy': sort?.value,
      'pageSize': pageSize ?? 10,
      'page': page,
      'domains': ['techcrunch.com', 'thenextweb.com'].join(','),
    }..removeEmptyValues();

    log('params => $queryParam');
    try {
      final response = await _networkService.get(
        dio: Dio(),
        endPoint: 'everything',
        isTokenRequired: true,
        queryParameters: queryParam,
      );

      final articles = AppResponse.fromJson(response, (json) {
        return Article.fromJson(json);
      });

      if (articles.isSuccess) {
        log(
          'total(${articles.totalResults}) articles => ${articles.results.length}',
        );
        return right(articles);
      }
      return left(
        ServerException(articles.message, null, int.tryParse(articles.code)),
      );
    } catch (e) {
      return left(ExceptionHandler.instance.parseError(e));
    }
  }
}
