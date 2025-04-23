import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_demo/core/core.dart';

@Injectable(as: RemoteService)
class RemoteServiceImpl extends RemoteService {
  @override
  Future<dynamic> delete({
    required Dio dio,
    required String endPoint,
    bool isTokenRequired = false,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await DioClient(dio: dio)
          .addInterceptors([
            // Interceptors here
          ])
          .delete('${dio.options.baseUrl}/$endPoint', cancelToken: cancelToken);
      if (response.statusCode == 204) {
        return;
      }
      return response.data;
    } on DioException catch (err) {
      throw ServerException(_getErrorMessage(err), err.stackTrace);
    }
  }

  @override
  Future<dynamic> get({
    required Dio dio,
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    bool isTokenRequired = false,
    CancelToken? cancelToken,
    void Function(int count, int total)? onRecieveProgress,
  }) async {
    try {
      final response = await DioClient(dio: dio)
          .addInterceptors([
            // Interceptors here
          ])
          .get(
            '${dio.options.baseUrl}/$endPoint',
            onReceiveProgress: onRecieveProgress,
            queryParameters: queryParameters,
            cancelToken: cancelToken,
          );
      if (response.statusCode == 204) {
        return;
      }
      return response.data;
    } on DioException catch (err) {
      throw ServerException(_getErrorMessage(err), err.stackTrace);
    }
  }

  @override
  Future<dynamic> patch({
    required Dio dio,
    required String endPoint,
    payloadObj,
    Map<String, dynamic>? queryParameters,
    bool isTokenRequired = false,
    CancelToken? cancelToken,
    void Function(int count, int total)? onSendProgress,
    void Function(int count, int total)? onRecieveProgress,
    bool useFormData = false,
  }) async {
    try {
      final response = await DioClient(dio: dio)
          .addInterceptors([
            // Interceptors here
          ])
          .patch(
            '${dio.options.baseUrl}/$endPoint',
            queryParameters: queryParameters,
            data: useFormData ? FormData.fromMap(payloadObj) : payloadObj,
            cancelToken: cancelToken,
            onReceiveProgress: onRecieveProgress,
            onSendProgress: onSendProgress,
          );
      return response.data;
    } on DioException catch (err) {
      throw ServerException(_getErrorMessage(err), err.stackTrace);
    }
  }

  @override
  Future<dynamic> post({
    required Dio dio,
    required String endPoint,
    payloadObj,
    Map<String, dynamic>? queryParameters,
    bool isTokenRequired = false,
    CancelToken? cancelToken,
    void Function(int count, int total)? onSendProgress,
    void Function(int count, int total)? onRecieveProgress,
    bool useFormData = false,
  }) async {
    try {
      final response = await DioClient(dio: dio)
          .addInterceptors([
            // Interceptors here
          ])
          .post(
            '${dio.options.baseUrl}/$endPoint',
            queryParameters: queryParameters,
            data: useFormData ? FormData.fromMap(payloadObj) : payloadObj,
            cancelToken: cancelToken,
            onReceiveProgress: onRecieveProgress,
            onSendProgress: onSendProgress,
          );
      return response.data;
    } on DioException catch (err) {
      throw ServerException(_getErrorMessage(err), err.stackTrace);
    }
  }

  @override
  Future<dynamic> put({
    required Dio dio,
    required String endPoint,
    payloadObj,
    Map<String, dynamic>? queryParameters,
    bool isTokenRequired = false,
    CancelToken? cancelToken,
    void Function(int count, int total)? onSendProgress,
    void Function(int count, int total)? onRecieveProgress,
    bool useFormData = false,
  }) async {
    try {
      final response = await DioClient(dio: dio)
          .addInterceptors([
            // Interceptors here
          ])
          .put(
            '${dio.options.baseUrl}/$endPoint',
            queryParameters: queryParameters,
            data: useFormData ? FormData.fromMap(payloadObj) : payloadObj,
            cancelToken: cancelToken,
            onReceiveProgress: onRecieveProgress,
            onSendProgress: onSendProgress,
          );
      return response.data;
    } on DioException catch (err) {
      throw ServerException(_getErrorMessage(err), err.stackTrace);
    }
  }
}

String _getErrorMessage(DioException error) {
  return switch (error.type) {
    DioExceptionType.badResponse when error.response?.statusCode == 400 =>
      'Bad Request',
    DioExceptionType.badResponse when error.response?.statusCode == 401 =>
      'Unauthorized',
    DioExceptionType.badResponse when error.response?.statusCode == 404 =>
      'Page Not Found',
    DioExceptionType.badResponse when error.response?.statusCode == 429 =>
      'Too many request',
    DioExceptionType.badResponse when error.response?.statusCode == 500 =>
      'Internal Server Error',
    DioExceptionType.badResponse when error.response?.statusCode == 502 =>
      'Server is Updating',
    DioExceptionType.badResponse when error.response?.statusCode == 502 =>
      'Server is Unreachable',
    DioExceptionType.badResponse =>
      error.response?.statusMessage ?? 'Bad Request',
    DioExceptionType.cancel => 'Request Cancelled',
    DioExceptionType.connectionError => 'No Internet Connection',
    DioExceptionType.connectionTimeout => 'Connection Timeout',
    DioExceptionType.unknown => 'Unexpected Error Occurred',
    DioExceptionType.sendTimeout => 'Send Timeout',
    DioExceptionType.receiveTimeout => 'Receive Timeout',
    _ => 'Unexpected Error Occurred',
  };
}
