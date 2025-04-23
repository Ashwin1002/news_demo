import 'package:dio/dio.dart';
import 'package:news_demo/core/core.dart';

const int kConnectionTimeOut = 10000;
const int kRecieveTimeOut = 10000;

class DioClient {
  DioClient({required Dio dio})
    : _dio =
          dio
            ..options.connectTimeout = Duration(
              milliseconds: kConnectionTimeOut,
            )
            ..options.receiveTimeout = Duration(milliseconds: kRecieveTimeOut)
            ..options.baseUrl = sl<EnvHelper>().get('API_BASE_URL');

  final Dio _dio;

  Dio addInterceptors(Iterable<Interceptor> interceptors) {
    return _dio..interceptors.addAll(interceptors);
  }
}
