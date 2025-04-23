part of 'home_bloc.dart';

final class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

final class FetchArticles extends HomeEvent {
  const FetchArticles({this.isRefresh = false, this.query, this.sort});

  final bool isRefresh;
  final String? query;
  final ArticleSort? sort;

  @override
  List<Object?> get props => [isRefresh, query, sort];
}
