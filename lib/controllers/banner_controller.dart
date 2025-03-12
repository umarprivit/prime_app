import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  RxList pages = [
    {
      "route": "assets/images/slider_1.png",
      "first": "LEARN",
      "second": "Watch recorder lectures"
    },
    {
      "route": "assets/images/slider_2.png",
      "first": "ATTEND",
      "second": "Anytime! Anywhere"
    },
    {
      "route": "assets/images/slider_3.png",
      "first": "DISCUSS",
      "second": "Ask and get education from live classes"
    },
  ].obs;

  RxInt currentIndex = 0.obs;
  PageController pageController = PageController();

  void nextPage() {
    if (currentIndex.value < 2) {
      pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipToLastPage() {
    pageController.jumpToPage(2);
  }
}