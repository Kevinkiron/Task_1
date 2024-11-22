import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_material/utils/kstyles.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    precacheImage(const AssetImage(AppImages.onboard1), context);
    precacheImage(const AssetImage(AppImages.onboard2), context);
    precacheImage(const AssetImage(AppImages.onboard3), context);
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Kstyles().bold(
                text: "Study Material",
                size: 20,
                color: AppColors.backgroundColor),
          ),
        ],
      ),
    );
  }
}
