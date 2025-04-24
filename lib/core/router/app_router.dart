import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:news_demo/core/router/router.dart';

@Singleton()
@Injectable()
@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: ArticleDetailRoute.page),
    AutoRoute(page: BookmarksRoute.page),
  ];
}
