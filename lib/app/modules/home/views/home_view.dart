import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:study_material/app/modules/home/views/courses_list.dart';
import 'package:study_material/app/routes/app_pages.dart';
import 'package:study_material/utils/app_colors.dart';
import 'package:study_material/utils/app_images.dart';
import 'package:study_material/utils/global.dart';
import 'package:study_material/utils/kstyles.dart';

import '../../../../utils/loader.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    log(controller.subjectList.toString());
    Get.put(HomeController());
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Obx(() {
        return controller.loading.value
            ? _skeletomLoader()
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: AppColors.primary,
                    floating: true,
                    expandedHeight: Constants.height * 0.17,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: AppColors.backgroundColor,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage(AppImages.backGround),
                          fit: BoxFit.contain,
                          colorFilter: ColorFilter.mode(
                            AppColors.primary.withOpacity(0.7),
                            BlendMode.srcOver,
                          ),
                        ),
                      ),
                      child: FlexibleSpaceBar(
                        centerTitle: false,
                        expandedTitleScale: 1.0,
                        titlePadding: EdgeInsets.all(20),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Kstyles().reg(
                              text: "Welcome to",
                              size: 14,
                              color: AppColors.backgroundColor,
                            ),
                            10.height,
                            Kstyles().semiBold(
                              text: "Study Material",
                              size: 20,
                              color: AppColors.backgroundColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: AppColors.backgroundColor,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_active_rounded,
                          color: AppColors.backgroundColor,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8.0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Kstyles()
                                    .semiBold(text: "Top Courses", size: 17),
                                TextButton.icon(
                                  style: ButtonStyle(
                                    padding:
                                        WidgetStatePropertyAll(EdgeInsets.zero),
                                  ),
                                  label: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                  ),
                                  onPressed: () {
                                    Get.to(() => CoursesList(),
                                        transition: Transition.rightToLeft);
                                  },
                                  icon:
                                      Kstyles().reg(text: 'View All', size: 14),
                                ),
                              ],
                            ),
                            10.height,
                            SizedBox(
                              height: Constants.height * 0.2,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return FadeInDown(
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.COURSE_DETAIL,
                                            arguments: {
                                              "id": controller
                                                  .subjectList[index].id
                                                  .toString()
                                            });
                                      },
                                      child: _courseCard(
                                        controller.subjectList[index].image ??
                                            "",
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            20.height,
                            Kstyles().semiBold(text: "All Courses", size: 17),
                            15.height,
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.subjectList.length,
                              itemBuilder: (context, index) {
                                return FadeInRight(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.COURSE_DETAIL,
                                          arguments: {
                                            "id": controller
                                                .subjectList[index].id
                                                .toString()
                                          });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            AppColors.primary.withOpacity(0.1),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Kstyles().semiBold(
                                            size: 14,
                                            text: controller
                                                    .subjectList[index].title ??
                                                "",
                                          ),
                                          5.height,
                                          Kstyles().light(
                                            overflow: TextOverflow.visible,
                                            size: 14,
                                            text: controller.subjectList[index]
                                                    .description ??
                                                "",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
      }),
    );
  }

  CustomScrollView _skeletomLoader() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: AppColors.primary,
          floating: true,
          expandedHeight: Constants.height * 0.17,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(AppImages.backGround),
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  AppColors.primary.withOpacity(0.7),
                  BlendMode.srcOver,
                ),
              ),
            ),
            child: FlexibleSpaceBar(
              centerTitle: false,
              expandedTitleScale: 1.0,
              titlePadding: EdgeInsets.all(20),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SkeletonBox(height: 10, width: 120),
                  10.height,
                  SkeletonBox(height: 10, width: 160),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonBox(height: 20, width: 120),
                10.height,
                SizedBox(
                  height: Constants.height * 0.2,
                  child: FadeInDown(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return SkeletonBox(
                          height: Constants.height * 0.2,
                          width: Constants.width * 0.55,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          margin: EdgeInsets.only(right: 15),
                        );
                      },
                    ),
                  ),
                ),
                20.height,
                const SkeletonBox(height: 20, width: 120),
                15.height,
                ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const SkeletonBox(
                      height: 70,
                      width: double.infinity,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      margin: EdgeInsets.only(bottom: 20),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _courseCard(String img) {
    return Container(
      width: Constants.width * 0.55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.only(right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: img,
          fit: BoxFit.fill,
          width: Constants.width,
          height: Constants.height,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
