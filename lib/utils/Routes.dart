import 'package:fluro/fluro.dart';
import '../pages/Setting.dart';
import '../pages/Search.dart';
import '../pages/Home.dart';

class Routes {
  static Router router;
  static String home = '/';
  static String setting = '/setting';
  static String search = '/search';

  static void configureRoutes(Router router) {
    router.define(home, handler: Handler(handlerFunc: (context, params) {
      return new Home();
    }));

    router.define(setting, handler: Handler(handlerFunc: (context, params) {
      return new SettingPage();
    }));

    router.define(search, handler: Handler(handlerFunc: (context, params) {
      return new SearchPage();
    }));

    print(Routes);

    Routes.router = router;
  }
}
