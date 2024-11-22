import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_material/app/modules/home/controllers/home_controller.dart';
import 'package:study_material/utils/app_colors.dart';
import 'package:study_material/utils/global.dart';
import 'package:study_material/utils/kstyles.dart';

import '../../../routes/app_pages.dart';

class CoursesList extends GetView<HomeController> {
  const CoursesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Kstyles().med(text: "All Subjects", size: 18),
        surfaceTintColor: AppColors.transparent,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Obx(() {
        return ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: controller.subjectList.length,
          itemBuilder: (context, index) {
            return FadeInDown(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.COURSE_DETAIL, arguments: {
                    "id": controller.subjectList[index].id.toString()
                  });
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
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          height: Constants.height * 0.6,
                          width: Constants.height * 0.1,
                          fit: BoxFit.fill,
                          errorWidget: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                          imageUrl: controller.subjectList[index].image ?? "",
                        ),
                      ),
                      subtitle: Kstyles().light(
                          overflow: TextOverflow.visible,
                          text: controller.subjectList[index].description ?? "",
                          size: 12),
                      title: Kstyles().semiBold(
                          text: controller.subjectList[index].title ?? "",
                          size: 14)),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
