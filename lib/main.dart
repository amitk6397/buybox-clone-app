import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/route/app_pages.dart';
import 'package:buybox_app/route/app_routes.dart';

import 'package:buybox_app/utils/components/bottom_navigationbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
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
  final NavigationbarController _controller = Get.put(
    NavigationbarController(),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _controller.onWillPop,
      child: Scaffold(
        body: Obx(() {
          return IndexedStack(
            index: _controller.index.value,
            children: List.generate(
              _controller.screenList.length,
              (i) => Navigator(
                key: _controller.navigatorKeys[i],
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                    builder: (_) => _controller.screenList[i],
                  );
                },
              ),
            ),
          );
        }),
        bottomNavigationBar: bottomNavigationBar(_controller),
      ),
    );
  }
}
