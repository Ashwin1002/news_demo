import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_demo/core/core.dart';
import 'package:news_demo/core/model/app_response/app_response.dart';
import 'package:news_demo/src/home/bloc/home/home_bloc.dart';
import 'package:news_demo/src/home/widgets/widgets.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeBloc();
      },
      child: const Scaffold(
        appBar: CustomAppbar(title: Text('Home'), hasShadow: true),
        body: _HomeView(key: ObjectKey('Home Screen View')),
      ),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView({super.key});

  @override
  State<_HomeView> createState() => __HomeViewState();
}

class __HomeViewState extends State<_HomeView> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScrollEndListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<HomeBloc>().add(const FetchArticles(isRefresh: true));
  }

  void _onScrollEndListener() {
    if (!_controller.isBottom) return;
    context.read<HomeBloc>().add(const FetchArticles());
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScrollEndListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<HomeBloc>().add(const FetchArticles(isRefresh: true));
      },
      child: CustomScrollView(
        controller: _controller,
        slivers: [
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (p, c) {
              return p.articles != c.articles;
            },
            builder: (context, state) {
              return state.articles.when(
                loading: () {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  );
                },
                failure: (exception) {
                  return SliverFillRemaining(
                    child: Center(child: Text(exception.message)),
                  );
                },
                success: (articles) {
                  final totalResults =
                      articles.totalResults >= 100
                          ? 100
                          : articles.totalResults;

                  final hasData =
                      state.articles
                          .get(() => AppResponse.initial())
                          .results
                          .length <
                      totalResults;

                  final count =
                      hasData
                          ? articles.results.length + 1
                          : articles.results.length;

                  return SliverList.builder(
                    itemCount: count,
                    itemBuilder: (context, index) {
                      if (index >= articles.results.length && hasData) {
                        return SizedBox(
                          height: 80.v,
                          width: Device.width,
                          child: const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        );
                      }

                      final article = articles.results[index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NewsTile(article: article),
                          if (index == articles.results.length - 1 && !hasData)
                            Padding(
                              padding: const EdgeInsets.all(AppPadding.large),
                              child: Center(
                                child: Text(
                                  'End of List',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: context.colorScheme.outline,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
