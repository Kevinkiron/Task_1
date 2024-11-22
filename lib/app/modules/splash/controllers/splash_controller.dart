import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_material/app/routes/app_pages.dart';

import '../../home/bindings/home_binding.dart';
import '../../home/views/home_view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    navigate();
    super.onInit();
  }

  Future<void> navigate() async {
    final prefs = await SharedPreferences.getInstance();

    final onBoard = prefs.getBool("onBoard");
    return Future.delayed(Duration(seconds: 3), () {
      if (onBoard == null || onBoard == true) {
        Get.offAllNamed(Routes.ONBOARD);
      } else {
        Get.offAll(
          () => const HomeView(),
          transition: Transition.downToUp,
          fullscreenDialog: true,
          binding: HomeBinding(),
          duration: const Duration(milliseconds: 1000),
        );
      }
    });
  }
}
