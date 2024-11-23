import 'dart:developer';

import 'package:get/get.dart';
import 'package:study_material/app/data/models/modules_model.dart';
import 'package:study_material/app/data/models/videos_model.dart';
import 'package:study_material/app/modules/course_detail/bindings/course_detail_binding.dart';

import '../../../data/api_service/api_constants.dart';
import '../../../data/api_service/helper_service.dart';
import '../views/module_details.dart';

class CourseDetailController extends GetxController {
  RxBool isLoading = true.obs;
  late String courseId;

  @override
  void onInit() {
    super.onInit();
    courseId = Get.arguments['id'];
    getModulesList();
  }

  RxList<ModulesModel> modulesList = <ModulesModel>[].obs;

  Future<void> getModulesList() async {
    final apiService = ApiService();

    try {
      final response = await apiService.callApi(
        endpoint: ApiConstants.getModules,
        method: 'POST',
        data: {
          "subject_id": courseId,
        },
      );

      if (response != null && response.statusCode == 200) {
        log('${response.data}');
        modulesList.value = modulesModelFromJson(response.data);
      } else {}
    } catch (e) {
      log('Error: $e');
    }
  }

  RxList<VideosModel> videosList = <VideosModel>[].obs;
  // RxString videoUrl = "".obs;

  Future<void> getModulesVideosList(int id) async {
    isLoading.value = true;
    final apiService = ApiService();

    try {
      final response = await apiService.callApi(
        endpoint: ApiConstants.getVideos,
        method: 'POST',
        data: {
          "module_id": id.toString(),
        },
      );

      if (response != null && response.statusCode == 200) {
        videosList.value = videosModelFromJson(response.data);

        isLoading.value = false;
        Get.to(() => const ModuleDetails(), binding: CourseDetailBinding());
      } else {}
    } catch (e) {
      log('Error: $e');
    }
  }
}
