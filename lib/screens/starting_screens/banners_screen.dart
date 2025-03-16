import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/banner_controller.dart';
import 'package:prime_app/routes.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BannerController con = Get.put(BannerController());

    return Scaffold(
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(""),
            // Image with Slide Transition
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(1, 0), // Start from right
                        end: Offset(0, 0), // Move to center
                      ).animate(animation),
                      child: child,
                    );
                  },
                  child: Image.asset(
                    con.pages[con.currentIndex.value]["route"],
                    key: ValueKey<int>(con.currentIndex.value),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 32, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: Text(
                          con.pages[con.currentIndex.value]["first"],
                          key: ValueKey<int>(con.currentIndex.value),
                          style: TextStyle(
                            fontFamily: Config.FONT_FAMILY,
                            color: Color.fromRGBO(221, 138, 35, 1),
                            fontSize: 51,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: Text(
                          con.pages[con.currentIndex.value]["second"],
                          key: ValueKey<int>(con.currentIndex.value),
                          style: TextStyle(
                            fontFamily: Config.FONT_FAMILY,
                            color: Theme.of(context).primaryColor,
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),

            // Text Section

            // Buttons Section
            Container(
              margin: EdgeInsets.only(left: 32, right: 32, bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // NEXT Button
                  TextButton(
                    onPressed: () {
                      if (con.currentIndex.value < con.pages.length - 1) {
                        con.currentIndex.value++;
                      } else if (con.currentIndex.value ==
                          con.pages.length - 1) {
                        Get.offAllNamed(Routes.WELCOME_SCREEN_ROUTE);
                      }
                    },
                    child: Text(
                      con.currentIndex.value == con.pages.length - 1
                          ? "FINISH"
                          : "NEXT",
                      style: TextStyle(
                        fontFamily: Config.FONT_FAMILY,
                        color: Theme.of(context).primaryColor,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  //Buttons ROw
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      con.pages.length,
                      (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: con.currentIndex.value == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: con.currentIndex.value == index
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).primaryColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

                  // SKIP Button
                  TextButton(
                    onPressed: () {
                      con.currentIndex.value = con.pages.length - 1;
                    },
                    child: Text(
                      "SKIP",
                      style: TextStyle(
                        fontFamily: Config.FONT_FAMILY,
                        color: Theme.of(context).primaryColor,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
