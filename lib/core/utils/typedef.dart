import 'package:fpdart/fpdart.dart';
import 'package:news_demo/core/core.dart';

typedef EitherData<T> = Either<AppException, T>;

typedef EitherFutureData<T> = Future<EitherData<T>>;
