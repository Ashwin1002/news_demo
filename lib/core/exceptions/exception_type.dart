import 'package:auto_route/auto_route.dart';

abstract class AppException implements Exception {
  final String message;
  final StackTrace? exception;
  AppException(this.message, [this.exception]);
}

class ServerException extends AppException {
  ServerException(super.message, [super.exception, this.statusCode]);
  final int? statusCode;
}

class CacheException extends AppException {
  CacheException(super.message, [super.exception]);
}

class RouteException extends AppException {
  RouteException(super.message, this.pageRouteInfo, [super.exception]);
  final PageRouteInfo pageRouteInfo;
}

class ParseException extends AppException {
  ParseException(super.message, [super.exception]);
}

class LocalDatabaseException extends AppException {
  LocalDatabaseException(super.message, [super.exception]);
}

class UnknownException extends AppException {
  UnknownException(super.message, [super.exception]);
}
