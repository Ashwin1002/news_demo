import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_demo/core/core.dart';
import 'package:news_demo/src/home/data/model/article.dart';
import 'package:news_demo/src/home/presentation/bloc/home_bloc.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return TapBouncer(
      onTap: () {
        context.router.push(
          ArticleDetailRoute(bloc: context.read<HomeBloc>(), article: article),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.medium,
          vertical: AppPadding.small,
        ),
        child: Column(
          spacing: 4.v,
          children: [
            Row(
              spacing: 8.h,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    spacing: 4.v,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.author,
                        style: context.textTheme.labelMedium?.copyWith(
                          letterSpacing: -.4,
                        ),
                      ),
                      Text(
                        article.title,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: -.4,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomNetWorkWidget(
                  url: article.urlToImage,
                  height: 72.h,
                  width: 72.h,
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                article.publishedAt.toTimesAgo(),
                style: context.textTheme.labelMedium?.copyWith(
                  letterSpacing: -.4,
                  color: context.colorScheme.outline,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Divider(
              height: 0,
              thickness: .8,
              color: context.colorScheme.outline.withValues(alpha: .2),
            ),
          ],
        ),
      ),
    );
  }
}
