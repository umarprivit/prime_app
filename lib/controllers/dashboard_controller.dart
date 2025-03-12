import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/models/course_model.dart';
import 'package:prime_app/service/firestore_service.dart';
import 'package:prime_app/service/shared_preferences.dart';

class DashboardController extends GetxController {
  var currentIndex = 1.obs;
  RxBool isLearnSelected = true.obs;
  RxBool isLoading = false.obs;
  RxBool isLibraryLoading = false.obs;
  RxBool isHomeLoading = false.obs;
  RxList enrolledCourses = [].obs;
  List<Course> courses = [];
  late Rx<Course> selectedSkill = Course(courseName: '', id: '').obs;
  final fs = FirestoreService();

  Future<void> requestCourse() async {
    try {
      isLoading.value = true;
      if (selectedSkill.value.id.isEmpty) {
        return;
      }
      await FirestoreService().addOrUpdateArrayField(
          fieldKey: await "${SharedPrefService().getDeviceId()}",
          newValues: [
            {
              "id": selectedSkill.value.id,
              "name": selectedSkill.value.courseName
            }
          ]);
      Get.back();
      Get.snackbar("Requested",
          "The Course has been requested and will appear in your library soon",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      // TODO
      Get.snackbar("Request Failed ", "Try Again later ",
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  void changePage(int index) {
    currentIndex.value = index;
  }

  Future<void> getHomePageSkills() async {
    try {
      isHomeLoading.value = true;
      var skills = await fs.getCoursesArray();
      courses = skills.map((e) => Course.fromJson(e)).toList();
      print(courses);
      isHomeLoading.value = false;
    } catch (e) {
      print("Error fetching courses: $e");
    }
  }

  Future<void> getDeviceCourses() async {
    try {
      // Get the device ID properly
      isLibraryLoading.value = true;
      String? deviceId = await SharedPrefService().getDeviceId();
      if (deviceId == null || deviceId.isEmpty) {
        print("Device ID not found");
        return;
      }

      // Fetch the list of course IDs assigned to this device
      List<dynamic> courseIds = await fs.getCoursesByDevice(deviceId);

      print("I am COURSE IDS: $courseIds");

      // Filter courses that match the courseIds
      enrolledCourses.clear(); // Clear before adding
      enrolledCourses.addAll(
        courses.where((e) => courseIds.contains(e.id)).toList(),
      );

      print("Enrolled Courses: $enrolledCourses");
    } catch (e) {
      print("Error fetching courses: $e");
    } finally {
      isLibraryLoading.value = false;
    }
  }
}
