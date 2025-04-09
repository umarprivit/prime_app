import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/models/course_model.dart';
import 'package:prime_app/service/firestore_service.dart';
import 'package:prime_app/service/notification_service.dart';
import 'package:prime_app/service/shared_preferences.dart';

class DashboardController extends GetxController {
  var currentIndex = 1.obs;
  RxBool isLearnSelected = true.obs;
  RxBool isLoading = false.obs;
  RxBool isLibraryLoading = false.obs;
  RxBool isHomeLoading = false.obs;
  RxList enrolledCourses = [].obs;

  List<Course> courses = [];
  List carouselImages = [
    "assets/images/carousel_image.png",
    "assets/images/carousel_image.png",
  ];
  Rx<Course> selectedSkill = Course(courseName: '', id: '').obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController DOBController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  Future<void> requestCourse() async {
    try {
      isLoading.value = true;
      if (selectedSkill.value.id.isEmpty) {
        return;
      }
      if (enrolledCourses
          .any((course) => course.id == selectedSkill.value.id)) {
        Get.snackbar(
            "Already Enrolled", "You are already enrolled in this course",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return;
      }
      String? token = await NotificationService().getToken();
      String deviceId = await SharedPrefService().getDeviceId()!;
      await FirestoreService()
          .addOrUpdateArrayField(fieldKey: deviceId, newValues: [
        {
          "id": selectedSkill.value.id,
          "name": selectedSkill.value.courseName,
          "token": token,
          "userName": nameController.text,
          "dob": DOBController.text,
          "city": cityController.text,
          "phoneNumber": phoneNumberController.text
        }
      ]);
      Get.back();
      Get.snackbar("Requested",
          "The Course has been requested and will appear in your library soon",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      if (e.toString().contains('already been requested')) {
        Get.snackbar(
            "Already Requested", "You have already requested this course",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } else {
        Get.snackbar("Request Failed ", "Try Again later ",
            backgroundColor: Colors.red);
      }
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
      var skills = await FirestoreService().getCoursesArray();

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
      List<dynamic> courses =
          await FirestoreService().getCoursesByDevice(deviceId);

      // Filter courses that match the courseIds
      if (courses.isEmpty) {
        print("No courses found for this device");
        enrolledCourses.clear();
        return;
      }
      // Fetch all courses from Firestore

      enrolledCourses.clear(); // Clear before adding
      enrolledCourses.addAll(
        courses.map((course) {
          return Course.fromJson(course);
        }).toList(),
      );

      print("Enrolled Courses: $enrolledCourses");
    } catch (e) {
      print("Error fetching courses: $e");
    } finally {
      isLibraryLoading.value = false;
    }
  }
}
