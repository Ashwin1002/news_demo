import 'package:dio/dio.dart';

abstract class RemoteService {
  Future<dynamic> get({
    required Dio dio,
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    bool isTokenRequired = false,
    CancelToken? cancelToken,
    void Function(int count, int total)? onRecieveProgress,
  });

  Future<dynamic> delete({
    required Dio dio,
    required String endPoint,
    bool isTokenRequired = false,
    CancelToken? cancelToken,
  });

  Future<dynamic> post({
    required Dio dio,
    required String endPoint,
    dynamic payloadObj,
    Map<String, dynamic>? queryParameters,
    bool isTokenRequired = false,
    CancelToken? cancelToken,
    void Function(int count, int total)? onSendProgress,
    void Function(int count, int total)? onRecieveProgress,
    bool useFormData = false,
  });

  Future<dynamic> put({
    required Dio dio,
    required String endPoint,
    dynamic payloadObj,
    Map<String, dynamic>? queryParameters,
    bool isTokenRequired = false,
    CancelToken? cancelToken,
    void Function(int count, int total)? onSendProgress,
    void Function(int count, int total)? onRecieveProgress,
    bool useFormData = false,
  });

  Future<dynamic> patch({
    required Dio dio,
    required String endPoint,
    dynamic payloadObj,
    Map<String, dynamic>? queryParameters,
    bool isTokenRequired = false,
    CancelToken? cancelToken,
    void Function(int count, int total)? onSendProgress,
    void Function(int count, int total)? onRecieveProgress,
    bool useFormData = false,
  });
}
