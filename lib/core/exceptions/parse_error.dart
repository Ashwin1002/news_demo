import 'package:news_demo/core/core.dart';
import 'package:news_demo/src/home/data/datasource/home_local_datasource.dart';
import 'package:sqflite/sqflite.dart';

class ExceptionHandler {
  const ExceptionHandler._();

  static ExceptionHandler get instance => const ExceptionHandler._();

  AppException parseError(Object e) {
    if (e is AppException) {
      return e;
    }

    if (e is DatabaseException) {
      return LocalDatabaseException(
        _getLocalDbExceptionMessage(e),
        StackTrace.fromString(e.result.toString()),
      );
    }
    return UnknownException(
      'Some error occurred',
      StackTrace.fromString(e.toString()),
    );
  }
}

String _getLocalDbExceptionMessage(DatabaseException e) {
  if (e.isDatabaseClosedError()) {
    return '$kDbName is closed';
  }
  if (e.isDuplicateColumnError()) {
    return '$kArticleTableName has a dublicate column';
  }
  if (e.isNoSuchTableError()) {
    return '"$kArticleTableName" table not found';
  }
  if (e.isNotNullConstraintError()) {
    return 'Constraint not null';
  }
  if (e.isOpenFailedError()) {
    return 'Failed to open database';
  }
  if (e.isReadOnlyError()) {
    return 'Failed to read from database';
  }
  if (e.isSyntaxError()) {
    return 'Invalid Syntax';
  }
  if (e.isUniqueConstraintError()) {
    return 'Unique constraint violated';
  }
  return 'Unknown database error';
}
