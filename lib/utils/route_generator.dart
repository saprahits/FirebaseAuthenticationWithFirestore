import 'package:demo/modules/dashboard/location/screen_add_location.dart';
import 'package:demo/modules/dashboard/home/view/screen_home.dart';
import 'package:demo/modules/auth/screen_login.dart';
import 'package:demo/modules/auth/screen_register.dart';
import 'package:demo/modules/splash/view/screen_splash.dart';
import 'package:demo/modules/dashboard/location/screen_view_location.dart';
import 'package:demo/utils/app_routes.dart';
import 'package:flutter/cupertino.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Todo: if need pass arguments then un comment
    //final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.routesSplash:
        return CupertinoPageRoute(
            builder: (_) => const ScreenSplash(),
            settings: const RouteSettings(name: AppRoutes.routesSplash));
      case AppRoutes.routesRegister:
        return CupertinoPageRoute(
            builder: (_) => const ScreenRegister(),
            settings: const RouteSettings(name: AppRoutes.routesRegister));
      case AppRoutes.routesLogin:
        return CupertinoPageRoute(
            builder: (_) => const ScreenLogin(),
            settings: const RouteSettings(name: AppRoutes.routesLogin));
      case AppRoutes.routesHome:
        return CupertinoPageRoute(
            builder: (_) => const ScreenHome(),
            settings: const RouteSettings(name: AppRoutes.routesHome));
      case AppRoutes.routesAddLocation:
        return CupertinoPageRoute(
            builder: (_) => const ScreenAddLocation(),
            settings: const RouteSettings(name: AppRoutes.routesAddLocation));
      case AppRoutes.routesViewLocation:
        return CupertinoPageRoute(
            builder: (_) => const ScreenViewLocation(),
            settings: const RouteSettings(name: AppRoutes.routesViewLocation));
      default:
        return CupertinoPageRoute(
            builder: (_) => const ScreenSplash(),
            settings: const RouteSettings(name: AppRoutes.routesSplash));
    }
  }
}
