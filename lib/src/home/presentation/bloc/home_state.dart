part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({required this.articles, required this.page});

  final BaseState<AppResponse<Article>> articles;
  final int page;

  factory HomeState.initial() {
    return const HomeState(articles: Initial(), page: 1);
  }

  @override
  List<Object?> get props => [articles, page];

  HomeState copyWith({BaseState<AppResponse<Article>>? articles, int? page}) {
    return HomeState(
      articles: articles ?? this.articles,
      page: page ?? this.page,
    );
  }
}
