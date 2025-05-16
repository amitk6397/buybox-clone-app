import 'package:buybox_app/controllers/start_app_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/rich_text.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget bottomContainer(StartAppController controller) {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        image: AssetImage('assets/images/cooking_background.webp'),
        fit: BoxFit.fill,
        opacity: 0.2,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Obx(() {
              return controller.index.value == 0
                  ? richText()
                  : controller.index.value == 1
                  ? richText2()
                  : richText3();
            }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              return Row(
                children:
                    controller.images.asMap().entries.map((entry) {
                      return Container(
                        width: entry.key == controller.index.value ? 30 : 10,
                        height: 10,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:
                              entry.key == controller.index.value
                                  ? AppColors.green
                                  : Colors.green.shade200,
                        ),
                      );
                    }).toList(),
              );
            }),
            Obx(() {
              return GestureDetector(
                onTap: () {
                  controller.addIndex();
                },
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.green,
                  ),
                  child: Center(
                    child: Text(
                      controller.images.length - 1 == controller.index.value
                          ? 'Get Started'
                          : "Next",
                      style: nextButton(),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ],
    ),
  );
}

Widget imageTop(StartAppController controller) {
  return Image.asset(
    controller.index.value == 0
        ? controller.images[0]
        : controller.index.value == 1
        ? controller.images[1]
        : controller.images[2],
    fit: BoxFit.cover,
    filterQuality: FilterQuality.high,
    width: double.infinity,
    height: 400,
  );
}
