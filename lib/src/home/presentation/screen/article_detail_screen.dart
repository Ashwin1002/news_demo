import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_demo/core/core.dart';
import 'package:news_demo/src/home/data/model/article.dart';
import 'package:news_demo/src/home/presentation/bloc/home_bloc.dart';

@RoutePage()
class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({
    super.key,
    required HomeBloc bloc,
    required this.article,
  }) : _bloc = bloc;

  final HomeBloc _bloc;
  final Article article;

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  late final HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = widget._bloc;
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    return BlocProvider<HomeBloc>.value(
      value: _bloc,
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  stretch: true,
                  pinned: true,
                  forceElevated: true,
                  backgroundColor: context.colorScheme.onPrimaryFixedVariant,
                  leading: BackButton(color: context.colorScheme.surface),
                  actions: [
                    BookmarkButton(article: article),
                    8.h.horizontalSpace,
                  ],
                  scrolledUnderElevation: 4.0,
                  shadowColor: context.colorScheme.shadow,
                  expandedHeight: 150.v,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: CustomNetWorkWidget(
                      url: article.urlToImage,
                      boxFit: BoxFit.cover,
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.medium,
                      vertical: AppPadding.large,
                    ),
                    child: Text(
                      article.title,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.medium,
                    ),
                    child: Row(
                      spacing: 8.h,
                      children: [
                        CustomNetWorkWidget.withInitials(
                          url: '',
                          initials: article.author.getFirstLetters(
                            isStartEnd: true,
                          ),
                          backgroundColor: context.colorScheme.tertiary,
                          shape: BoxShape.circle,
                          height: 40.h,
                          width: 40.h,
                        ),
                        Text(
                          article.author,
                          style: context.textTheme.bodyMedium,
                        ),
                        const Spacer(),
                        Text(
                          article.publishedAt.toTimesAgo(),
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.outline,
                            letterSpacing: -.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.large,
                      vertical: AppPadding.large,
                    ),
                    child: Text(
                      article.description,
                      style: context.textTheme.bodyMedium?.copyWith(
                        height: 2.0,
                        color: context.colorScheme.onSecondaryFixedVariant,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.medium,
                    ),
                    child: Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            UrlUtils.openUrlInAppWebView(url: article.url);
                          },
                          child: const Text('Read Full Article...'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverFillRemaining(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BookmarkButton extends StatelessWidget {
  const BookmarkButton({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      buildWhen: (p, c) {
        return p.bookmarks != c.bookmarks;
      },
      listenWhen: (p, c) {
        return p.bookmarks != c.bookmarks;
      },
      listener: (context, state) {
        state.bookmarks.listenWhen(
          success: (bookmarks) {
            final bookmark =
                bookmarks.where((e) => e.url == article.url).firstOrNull;
            if (bookmark?.isFavourite == true) {
              Snack.success(context, 'Article added to bookmarks!');
            } else {
              Snack.error(context, 'Article removed from bookmarks!');
            }
          },
        );
      },
      builder: (context, state) {
        final child = _buildButton(context, false);
        return TapBouncer(
          onTap: () {
            context.read<HomeBloc>().add(ToogleBookmark(article));
          },
          child: state.bookmarks.when(
            loading: () => child,
            failure: (exception) => child,
            success: (bookmarks) {
              final bookmark =
                  bookmarks.where((e) => e.url == article.url).firstOrNull;
              return _buildButton(context, bookmark?.isFavourite == true);
            },
          ),
        );
      },
    );
  }

  Widget _buildButton(BuildContext context, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.small),
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Icon(
        Icons.bookmark_rounded,
        color:
            isSelected
                ? context.colorScheme.primary
                : context.colorScheme.surface,
      ),
    );
  }
}
