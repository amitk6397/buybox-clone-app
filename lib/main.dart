import 'package:buybox_app/controllers/firebase_auth_controller.dart';
import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/route/app_pages.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/splash_screen.dart';
import 'package:buybox_app/utils/components/bottom_navigationbar.dart';
import 'package:buybox_app/views/category/categories_page.dart';
import 'package:buybox_app/views/favorites_items_page.dart';
import 'package:buybox_app/views/home/home_screen.dart';
import 'package:buybox_app/views/profile/profiel_screen.dart';
import 'package:buybox_app/views/shopping_cart_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  // await FirebaseApi().initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final NavigationbarController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: _controller.index.value,
          children: _controller.screenList,
        );
      }),
      bottomNavigationBar: bottomNavigationBar(_controller),
    );
  }
}
