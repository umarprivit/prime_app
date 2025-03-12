import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/dashboard_controller.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/service/shared_preferences.dart';

class LoginscreenController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isGuest = false.obs;
  RxBool isLoggedIn = false.obs;
  RxBool isLoading = false.obs;

  loginAsGuest() async {
    DashboardController con = Get.put(DashboardController());
    isLoading.value = true;
    isGuest.value = true;
    isLoggedIn.value = true;
    await SharedPrefService().setIsGuest(true);
    await SharedPrefService()
        .setDeviceId(await Config().getDeviceId() as String);
    await SharedPrefService().setIsLoggedIn(true);
    await con.getHomePageSkills();
    await con.getDeviceCourses();
    isLoading.value = false;
    Get.offAllNamed(Routes.DASHBOARD_SCREEN_ROUTE);
  }

  logoutAsGuest() async {
    isLoading.value = true;
    SharedPrefService().clearAll();

    isLoading.value = false;
    Get.offAllNamed(Routes.WELCOME_SCREEN_ROUTE);
  }
}
