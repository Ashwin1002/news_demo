import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_demo/core/core.dart';
import 'package:news_demo/core/model/app_response/app_response.dart';
import 'package:news_demo/src/home/data/datasource/home_remote_datasource.dart';
import 'package:news_demo/src/home/data/model/article.dart';
import 'package:news_demo/src/home/domain/repository/home_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'home_event.dart';
part 'home_state.dart';

EventTransformer<E> throttleDroppable<E>([Duration? duration]) {
  return (events, mapper) {
    return droppable<E>().call(
      events.throttle(duration ?? const Duration(milliseconds: 100)),
      mapper,
    );
  };
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _remoteRepository;
  HomeBloc()
    : _remoteRepository = sl<HomeRepository>(),
      super(HomeState.initial()) {
    on<CheckNetworkConnection>(_checkConnection, transformer: restartable());
    on<FetchArticles>(_fetchArticles, transformer: throttleDroppable());
    on<ToogleBookmark>(_toggleBookMark);
    on<FetchBookMarks>(_fetchBookmarks);
  }

  FutureOr<void> _checkConnection(
    CheckNetworkConnection event,
    Emitter<HomeState> emit,
  ) async {
    final stream = sl<InternetConnectionChecker>().onStatusChange;
    await emit.forEach(
      stream,
      onData: (status) {
        return state.copyWith(connectionStatus: status);
      },
    );
  }

  FutureOr<void> _fetchArticles(
    FetchArticles event,
    Emitter<HomeState> emit,
  ) async {
    if (event.isRefresh) {
      emit(state.copyWith(articles: const Loading(), page: 1));
    }

    if (state.articles.isSuccess) {
      final total = state.articles.getOrNull()?.totalResults ?? 0;
      final count = state.articles.getOrNull()?.results.length ?? 0;

      /// This is due to the api is limited to 100 results for free plan
      if (count >= (total >= 100 ? 100 : total)) return;
    }

    if (state.articles.isLoading) {
      final result = await _remoteRepository.fetchArticles(query: event.query);

      result.fold(
        (l) => emit(state.copyWith(articles: Failure(l))),
        (r) => emit(state.copyWith(articles: Success(r), page: state.page + 1)),
      );
      return;
    }

    final result = await _remoteRepository.fetchArticles(
      query: event.query,
      page: state.page,
    );

    if (result.isLeft()) return;

    final newArticles = result.getRight().getOrElse(
      () => AppResponse.initial(),
    );

    final articles = List<Article>.from(
      state.articles.get(() => AppResponse.initial()).results,
    )..addAll(newArticles.results);

    emit(
      state.copyWith(
        articles: Success(
          AppResponse<Article>.initial().copyWith(
            totalResults: newArticles.totalResults,
            results: articles,
          ),
        ),
        page: state.page + 1,
      ),
    );
  }

  FutureOr<void> _fetchBookmarks(
    FetchBookMarks event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(bookmarks: const Loading()));
    final results = await _remoteRepository.fetchBookMarks();

    results.fold(
      (l) => emit(state.copyWith(bookmarks: Failure(l))),
      (r) => emit(state.copyWith(bookmarks: Success(r))),
    );
  }

  FutureOr<void> _toggleBookMark(
    ToogleBookmark event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(bookmarks: const Loading()));
    final article = await _remoteRepository.updateBookMark(event.article);

    if (article.isRight()) {
      final updated = article.getRight().getOrElse(() => Article.initial());

      final articles =
          List<Article>.from(
            state.articles.get(() => AppResponse.initial()).results,
          ).map((e) {
            if (e.url == updated.url && e.publishedAt == updated.publishedAt) {
              return e.copyWith(isFavourite: updated.isFavourite);
            }
            return e;
          }).toList();

      emit(state.copyWith(bookmarks: Success(articles)));
    }

    if (article.isLeft()) {
      emit(
        state.copyWith(
          bookmarks: Failure(
            article.getLeft().getOrElse(
              () => UnknownException('Unknown error occurred'),
            ),
          ),
        ),
      );
    }
  }
}
