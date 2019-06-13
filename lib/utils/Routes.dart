import 'package:fluro/fluro.dart';
// import '../pages/Animate.dart';
// import '../pages/Detail.dart';

class Routes {
  static Router router;
  static String animatePage = '/animate';
  static String detailPage = '/detail';

  static void configureRoutes(Router router) {
    // router.define(
    //     animatePage, handler: Handler(handlerFunc: (context, params) => StaggeredAnimationReplication()));
    // router.define(
    //     detailPage, handler: Handler(handlerFunc: (context, params) {
    //   // var message = params['message']?.first; //取出传参
    //   return DetailPage();
    // }), transitionType: TransitionType.inFromBottom);
    Routes.router = router;
  }
}
