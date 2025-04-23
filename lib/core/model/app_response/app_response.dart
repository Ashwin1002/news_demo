import 'package:equatable/equatable.dart';
import 'package:news_demo/core/utils/extension/map_extension.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> data);
typedef ToJson<T> = Map<String, dynamic> Function(T data);

class AppResponse<T> extends Equatable {
  const AppResponse({
    required this.status,
    required this.totalResults,
    required this.results,
    required this.code,
    required this.message,
  });

  final String status;
  final int totalResults;
  final List<T> results;
  final String code;
  final String message;

  factory AppResponse.initial([List<T>? results]) => AppResponse<T>(
    results: results ?? <T>[],
    code: '',
    message: '',
    status: '',
    totalResults: -1,
  );

  factory AppResponse.fromJson(
    Map<String, dynamic> json,
    FromJson<T> fromJson,
  ) {
    return AppResponse<T>(
      status: json['status'] ?? '',
      totalResults: int.tryParse(json['totalResults'].toString()) ?? -1,
      code: json['code'] ?? '',
      message: json['message'] ?? '',
      results:
          json['articles'] is List<dynamic>
              ? (json['articles'] as List<dynamic>)
                  .map((e) => fromJson(e))
                  .toList()
              : <T>[],
    );
  }

  Map<String, dynamic> toJson(ToJson<T> toJson) {
    return {
      'status': status,
      'totalResults': totalResults < 0 ? null : totalResults,
      'code': code,
      'message': message,
      'articles': results.map((x) => toJson.call(x)).toList(),
    }..removeEmptyValues();
  }

  bool get isSuccess => status == 'ok';
  bool get isFailure => status == 'error';

  @override
  List<Object?> get props => [status, totalResults, code, message, results];

  AppResponse<T> copyWith({
    String? status,
    int? totalResults,
    List<T>? results,
    String? code,
    String? message,
  }) {
    return AppResponse<T>(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }
}
