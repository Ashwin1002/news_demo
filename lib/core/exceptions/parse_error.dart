import 'package:news_demo/core/core.dart';

class ExceptionHandler {
  const ExceptionHandler._();

  static ExceptionHandler get instance => const ExceptionHandler._();

  AppException parseError(Object e) {
    if (e is AppException) {
      return e;
    }
    return UnknownException(
      'Some error occurred',
      StackTrace.fromString(e.toString()),
    );
  }
}
