import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_demo/core/utils/date_json_converter.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
sealed class Article with _$Article {
  const Article._();
  factory Article({
    @Default(-1) int id,
    @Default('') String author,
    @Default('') String title,
    @Default('') String description,
    @Default('') String url,
    @Default('') String urlToImage,
    @DateTimeConverter() required DateTime publishedAt,
    @Default('') String content,
    @JsonKey(includeToJson: false) bool? isFavourite,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  factory Article.initial() => Article(publishedAt: DateTime(2000));
}
