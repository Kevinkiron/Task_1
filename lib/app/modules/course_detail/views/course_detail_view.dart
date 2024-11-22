import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/kstyles.dart';
import '../controllers/course_detail_controller.dart';

class CourseDetailView extends GetView<CourseDetailController> {
  const CourseDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Kstyles().med(
          text: "Course",
          size: 18,
        ),
        surfaceTintColor: AppColors.transparent,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Obx(() {
        return ListView.separated(
          separatorBuilder: (context, index) {
            return Divider();
          },
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          itemCount: controller.modulesList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                controller.getModulesVideosList(
                    controller.modulesList[index].id ?? 0);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.only(bottom: 20),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primary,
                    size: 18,
                  ),
                  subtitle: Kstyles().light(
                    overflow: TextOverflow.visible,
                    text: controller.modulesList[index].description ?? "",
                    size: 12,
                  ),
                  title: Kstyles().med(
                    text: controller.modulesList[index].title ?? "",
                    size: 14,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
