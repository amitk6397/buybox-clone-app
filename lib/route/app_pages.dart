import 'package:buybox_app/binding/auth_binding.dart';
import 'package:buybox_app/binding/home_binding.dart';
import 'package:buybox_app/binding/order_binding.dart';
import 'package:buybox_app/binding/profile_binding.dart';
import 'package:buybox_app/binding/search_binding.dart';
import 'package:buybox_app/main.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/splash_screen.dart';
import 'package:buybox_app/views/auth/forgot_password.dart';
import 'package:buybox_app/views/auth/login_page.dart';
import 'package:buybox_app/views/auth/signIn_page.dart';
import 'package:buybox_app/views/category/all_category_items.dart';
import 'package:buybox_app/views/category/categories_page.dart';
import 'package:buybox_app/views/category/details_page.dart';
import 'package:buybox_app/views/home/home_screen.dart';
import 'package:buybox_app/views/location_page.dart';
import 'package:buybox_app/views/order/address_screen.dart';
import 'package:buybox_app/views/order/payment_screen.dart';
import 'package:buybox_app/views/profile/personalInfo_page.dart';
import 'package:buybox_app/views/search_products.dart';
import 'package:buybox_app/views/start_page/start_pages.dart';

import 'package:get/get.dart';

class AppPages {
  static final pages = [
    //Splash Screen
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(name: AppRoutes.startApp, page: () => StartPages()),

    //Auth login signin forgot
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => SigninPage(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => ForgotPassword(),
      binding: AuthBinding(),
    ),

    //Home and Location
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.myHome,
      page: () => MyHomePage(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: AppRoutes.location,
      page: () => LocationPage(),
      binding: HomeBinding(),
    ),

    // Categories Screen
    GetPage(name: AppRoutes.category, page: () => CategoriesPage()),

    GetPage(name: AppRoutes.details, page: () => DetailsPage()),

    // Profile Screen
    GetPage(
      name: AppRoutes.personalInfo,
      page: () => PersonalInfoPage(),
      binding: ProfileBinding(),
    ),

    // Search Screeen
    GetPage(
      name: AppRoutes.search,
      page: () => SearchProducts(),
      binding: SearchBinding(),
    ),

    //Order page Payment Screen
    GetPage(
      name: AppRoutes.order,
      page: () => AddressScreen(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => PaymentScreen(),
      binding: OrderBinding(),
    ),
  ];
}
