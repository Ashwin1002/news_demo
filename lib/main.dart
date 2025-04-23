import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:news_demo/core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    // injection init
    configureInjection(),
    // read data from session
    SecureStorage.instance.readAll(),
    // Initialization of EnvHelper
    EnvHelper.init(),
  ]);
  runApp(const MyApp());
}

final _router = sl<AppRouter>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Device.setScreenSize(context, constraints);
        TextTheme textTheme = createTextTheme(context, 'Sora', 'Sora');
        MaterialTheme theme = MaterialTheme(textTheme);
        return MaterialApp.router(
          title: 'News Demo',
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: ThemeMode.system,
          routeInformationParser: _router.defaultRouteParser(),
          routerDelegate: AutoRouterDelegate(_router),
        );
      },
    );
  }
}
