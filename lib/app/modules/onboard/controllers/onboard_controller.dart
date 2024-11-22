import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_material/app/modules/home/bindings/home_binding.dart';
import 'package:study_material/app/modules/home/views/home_view.dart';
import 'package:study_material/utils/app_images.dart';

import '../../../data/models/models.dart';

class OnboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final PageController pageController = PageController();
  late AnimationController animationController;
  late Animation<double> animation;
  final RxDouble currentProgress = 0.0.obs;

  final List<OnboardModel> onboardItems = [
    OnboardModel(
      img: AppImages.onboard1,
      title: "Welcome to Study Material",
      desc:
          "Explore a wide range of courses and learning resources. Empower your knowledge and skills with our user-friendly app.",
    ),
    OnboardModel(
      img: AppImages.onboard2,
      title: "Learn Anytime, Anywhere",
      desc:
          "Access your study materials anytime and study at your own pace. Make learning convenient and effective with Study Material.",
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 1 / onboardItems.length)
        .animate(animationController)
      ..addListener(() {
        currentProgress.value = animation.value;
      });
    animationController.forward();
  }

  void onPageChanged(int page) {
    animationController.reset();
    animation = Tween<double>(
      begin: page / onboardItems.length,
      end: (page + 1) / onboardItems.length,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    animationController.forward();
  }

  void nextPage() async {
    if (pageController.page! < onboardItems.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('onBoard', false);
      Get.offAll(
        () => const HomeView(),
        transition: Transition.downToUp,
        fullscreenDialog: true,
        binding: HomeBinding(),
        duration: const Duration(milliseconds: 1000),
      );
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    animationController.dispose();
    super.onClose();
  }
}
