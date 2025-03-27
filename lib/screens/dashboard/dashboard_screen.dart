import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/dashboard_controller.dart';
import 'package:prime_app/screens/dashboard/homeScreen.dart';
import 'package:prime_app/screens/dashboard/library_screen.dart';
import 'package:prime_app/widgets/app_drawer.dart';
import 'package:prime_app/widgets/dashboard_widgets/custom_appBar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController(initialPage: 1);

  @override
  void initState() {
    super.initState();
    Get.put(DashboardController());
  }

  @override
  Widget build(BuildContext context) {
    DashboardController con = Get.find<DashboardController>();
    CarouselSliderController carouselController = CarouselSliderController();

    return SafeArea(
      child: Scaffold(
          // App Bar
          appBar: CustomAppBar(),

          // App Drawer
          drawer: AppDrawer(),

          // Bottom Navigation Bar
          bottomNavigationBar: Container(
            height: 98,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.63),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  offset: Offset(0, -3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    icon: Icons.auto_awesome,
                    label: "Chatbot",
                    index: 0,
                    controller: con,
                  ),
                  _buildNavItem(
                    icon: con.currentIndex.value == 1
                        ? Icons.home_filled
                        : Icons.home_outlined,
                    label: "Home",
                    index: 1,
                    controller: con,
                  ),
                  _buildNavItem(
                    icon: con.currentIndex.value == 2
                        ? Icons.library_books
                        : Icons.library_books_outlined,
                    label: "Library",
                    index: 2,
                    controller: con,
                  ),
                ],
              ),
            ),
          ),

          //Body
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) => con.currentIndex.value = index,
              children: [
                // Profile Screen but not implemented because design not provided in figma
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text("Chatbot",
                    //     style: TextStyle(
                    //         fontSize: 50,

                    //         color: Colors.amber,
                    //         fontWeight: FontWeight.bold)),
                    Image.asset("assets/images/welcome_bot.png"),
                    Text("Coming Soon!",
                        style: TextStyle(
                            fontSize: 50,
                            fontFamily: Config.FONT_FAMILY,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold)),
                  ],
                )),

                // Home Screen
                Homescreen(),

                // Library Screen
                LibraryScreen(),
              ],
            ),
          )),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required DashboardController controller,
  }) {
    bool isActive = controller.currentIndex.value == index;

    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 26,
                  color: isActive
                      ? Theme.of(Get.context!).primaryColor
                      : Config.GREY_COLOR,
                ),
                Text(
                  label,
                  style: TextStyle(
                    color: Config.GREY_COLOR,
                    fontFamily: Config.FONT_FAMILY,
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 4,
            width: 85,
            color: isActive
                ? Theme.of(Get.context!).primaryColor
                : Config.GREY_COLOR_40,
          )
        ],
      ),
    );
  }
}
