import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/splash_screen.dart';
import 'package:buybox_app/views/auth/login_page.dart';
import 'package:buybox_app/views/auth/signIn_page.dart';
import 'package:buybox_app/views/start_page/start_pages.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(name: AppRoutes.startApp, page: () => StartPages()),
    GetPage(name: AppRoutes.login, page: () => LoginPage()),
    GetPage(name: AppRoutes.signIn, page: () => SigninPage()),
  ];
}
