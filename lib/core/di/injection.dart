import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:news_demo/core/core.dart';

///
///Dependency Injection Cannot be done with classes with constructors
///
final GetIt sl = GetIt.instance;

@injectableInit
Future<void> configureInjection() async {
  sl.init();
}
