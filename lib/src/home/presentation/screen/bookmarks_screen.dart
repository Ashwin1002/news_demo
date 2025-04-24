import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_demo/core/core.dart';
import 'package:news_demo/src/home/presentation/bloc/home_bloc.dart';
import 'package:news_demo/src/home/presentation/widgets/widgets.dart';

@RoutePage()
class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key, required this.bloc});

  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: Text('Bookmarks'), hasShadow: true),
      body: BlocProvider<HomeBloc>.value(
        value: bloc..add(const FetchBookMarks()),
        child: Builder(
          builder: (context) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                context.read<HomeBloc>().add(const FetchBookMarks());
              },
              child: CustomScrollView(
                slivers: [
                  10.v.sliverVerticalSpace,
                  BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (p, c) {
                      return p.bookmarks != c.bookmarks;
                    },
                    builder: (context, state) {
                      return state.bookmarks.when(
                        loading: () {
                          return const SliverFillRemaining(
                            child: Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          );
                        },
                        failure: (exception) {
                          return SliverFillRemaining(
                            child: Padding(
                              padding: const EdgeInsets.all(AppPadding.large),
                              child: Center(
                                child: Text(
                                  exception.message,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        },
                        success: (bookmarks) {
                          if (bookmarks.isEmpty) {
                            return const SliverFillRemaining(
                              child: Padding(
                                padding: EdgeInsets.all(AppPadding.large),
                                child: Center(
                                  child: Text(
                                    'No Articles found',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          }

                          return SliverList.builder(
                            itemCount: bookmarks.length,
                            itemBuilder: (context, index) {
                              final article = bookmarks[index];
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  NewsTile(article: article),
                                  if (index == bookmarks.length - 1)
                                    Padding(
                                      padding: const EdgeInsets.all(
                                        AppPadding.large,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'End of List',
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                                color:
                                                    context.colorScheme.outline,
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
          },
        ),
      ),
    );
  }
}
