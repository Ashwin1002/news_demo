part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.articles,
    required this.page,
    required this.connectionStatus,
    required this.bookmarks,
  });

  final BaseState<AppResponse<Article>> articles;
  final int page;
  final InternetConnectionStatus connectionStatus;
  final BaseState<List<Article>> bookmarks;

  factory HomeState.initial() {
    return const HomeState(
      articles: Initial(),
      page: 1,
      connectionStatus: InternetConnectionStatus.disconnected,
      bookmarks: Initial(),
    );
  }

  @override
  List<Object?> get props => [articles, page, connectionStatus, bookmarks];

  HomeState copyWith({
    BaseState<AppResponse<Article>>? articles,
    int? page,
    InternetConnectionStatus? connectionStatus,
    BaseState<List<Article>>? bookmarks,
  }) {
    return HomeState(
      connectionStatus: connectionStatus ?? this.connectionStatus,
      articles: articles ?? this.articles,
      page: page ?? this.page,
      bookmarks: bookmarks ?? this.bookmarks,
    );
  }
}
