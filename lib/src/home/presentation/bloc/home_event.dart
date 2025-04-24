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

final class CheckNetworkConnection extends HomeEvent {
  const CheckNetworkConnection();

  @override
  List<Object?> get props => [];
}

final class FetchBookMarks extends HomeEvent {
  const FetchBookMarks();

  @override
  List<Object?> get props => [];
}

final class ToogleBookmark extends HomeEvent {
  const ToogleBookmark(this.article);

  final Article article;

  @override
  List<Object?> get props => [article];
}
