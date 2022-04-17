import '../mobx/view/home_page/home_page.dart';

class AppRoute {
  static AppRoute? _instance;
  static AppRoute get instance {
    _instance ??= AppRoute._init();
    return _instance!;
  }

  AppRoute._init();

  static const String initialRoute = '/';

  static get appRoutes => {
        initialRoute: (context) => const HomePage(),
      };
}
