import 'package:buybox_app/controllers/add_remove_cart_controller.dart';
import 'package:buybox_app/controllers/user_controller/image_picker_controller.dart';
import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/controllers/serach_screen_item_controller.dart';
import 'package:buybox_app/route/app_pages.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/components/bottom_navigationbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final directory = await getApplicationDocumentsDirectory();
  Get.put(SerachScreenItemController(), permanent: true);
  Get.put(AddRemoveCartController(), permanent: true);
  Get.put(ImagePickerController(), permanent: true);
  Get.lazyPut(() => NavigationbarController(), fenix: true);
  Hive.init(directory.path);
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
  final NavigationbarController _controller = Get.find();

  final AddRemoveCartController _controller1 = Get.find();
  final ImagePickerController _controller2 = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          final shouldPop = await _controller.onWillPop();
          if (shouldPop) {
            Future.delayed(Duration(milliseconds: 100), () {
              SystemNavigator.pop();
            });
          }
        }
      },
      child: Scaffold(
        body: Obx(() {
          return IndexedStack(
            index: _controller.index.value,
            children: List.generate(
              5,
              (i) => Navigator(
                key: _controller.navigatorKeys[i],
                onGenerateRoute:
                    (_) => MaterialPageRoute(
                      builder: (_) => _controller.pages[i](),
                    ),
              ),
            ),
          );
        }),
        bottomNavigationBar: bottomNavigationBar(
          _controller,
          _controller1,
          _controller2,
        ),
      ),
    );
  }
}
