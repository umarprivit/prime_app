import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupscreenController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  RxList countryCodes = [
    "+92",
    "+41",
    "+1",
    "+91",
    "+93",
    "+355",
  ].obs;
  RxList interests = ["MDCAT", "CSS", "Intermediate", "Entry Test"].obs;
  RxList city = ["Sukkur","Islamabad","Rawalpindi","Faislabad"].obs;
  final RxString countryCode = "+92".obs;
  final RxString choosedCity = "Sukkur".obs;
  final RxString choosedInterest = "MDCAT".obs;

}
