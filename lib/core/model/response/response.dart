import 'package:freezed_annotation/freezed_annotation.dart';

part 'response.freezed.dart';
part 'response.g.dart';

@Freezed(genericArgumentFactories: true, copyWith: false)
sealed class Response<T> with _$Response {
  const Response._();

  factory Response.success({
    required String status,
    required int totalResults,
    @JsonKey(name: 'articles') required List<T> data,
  }) = _ResponseSuccess<T>;

  factory Response.error({
    required String status,
    required String code,
    required String message,
  }) = _ResponseError<T>;

  factory Response.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ResponseFromJson(json, fromJsonT);
}
