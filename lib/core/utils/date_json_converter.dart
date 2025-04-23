import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_demo/core/core.dart';

class DateTimeConverter implements JsonConverter<DateTime, dynamic> {
  const DateTimeConverter();
  @override
  DateTime fromJson(dynamic json) {
    if (json == null) {
      return DateTime.now();
    }

    if (json is String && DateTime.tryParse(json) != null) {
      return DateTime.parse(json).isUtc
          ? DateTime.parse(json)
          : DateTime.parse(json).toUtc();
    }

    throw ParseException('Invalid date format : $json');
  }

  @override
  dynamic toJson(DateTime date) {
    return date.isUtc ? date.toIso8601String() : date.toUtc().toIso8601String();
  }
}
