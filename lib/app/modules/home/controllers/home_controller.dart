import 'dart:developer';

import 'package:get/get.dart';
import 'package:study_material/app/data/api_service/api_constants.dart';
import 'package:study_material/app/data/models/subject_model.dart';

import '../../../data/api_service/helper_service.dart';

class HomeController extends GetxController {
  RxList<SubjectModel> subjectList = <SubjectModel>[].obs;
  RxBool loading = false.obs;
  @override
  void onInit() {
    getSubjectsList();
    super.onInit();
  }

  Future<void> getSubjectsList() async {
    loading.value = true;
    final apiService = ApiService();

    try {
      final response = await apiService.callApi(
        endpoint: ApiConstants.getSubjects,
        method: 'GET',
      );

      if (response != null && response.statusCode == 200) {
        subjectList.value = subjectModelFromJson(response.data);
        loading.value = false;
      } else {
        log(' ${response?.statusCode}');
        loading.value = false;
      }
    } catch (e) {
      log('Error: $e');
      loading.value = false;
    }
  }
}
