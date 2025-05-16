import 'package:buybox_app/controllers/start_app_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/rich_text.dart';
import 'package:buybox_app/utils/components/start_app_cpmponents.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartPages extends StatefulWidget {
  const StartPages({super.key});

  @override
  State<StartPages> createState() => _StartPagesState();
}

class _StartPagesState extends State<StartPages> {
  final StartAppController controller = StartAppController();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppColors.green,
      body:
          mediaQuery.orientation == Orientation.portrait
              ? Column(
                children: [
                  SizedBox(height: 60),
                  Obx(() => imageTop(controller)),
                  Expanded(child: bottomContainer(controller)),
                ],
              )
              : Row(
                children: [
                  Obx(() => Expanded(child: imageTop(controller))),
                  Expanded(child: bottomContainer(controller)),
                ],
              ),
    );
  }
}
