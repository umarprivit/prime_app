import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/dashboard_controller.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/widgets/dashboard_widgets/library_container.dart';
import 'package:prime_app/widgets/shimmering_skeltons/library_container_skelton.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController con = Get.find<DashboardController>();
    con.getDeviceCourses();

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          // Toggle Section for Learn / Quiz
          Obx(
            () => Container(
              height: 50,
              width: 302, // Fixed width to match border
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Stack(
                children: [
                  // Animated Background for Active Tab
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left:
                        con.isLearnSelected.value ? 0 : 149, // Adjust movement
                    child: Container(
                      width: 153,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  // Border and Text
                  Container(
                    width: 302,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => con.isLearnSelected.value = true,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Learn',
                                style: TextStyle(
                                  fontFamily: Config.FONT_FAMILY,
                                  fontSize: 22,
                                  color: con.isLearnSelected.value
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => con.isLearnSelected.value = false,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Quiz',
                                style: TextStyle(
                                  fontFamily: Config.FONT_FAMILY,
                                  fontSize: 22,
                                  color: con.isLearnSelected.value
                                      ? Theme.of(context).primaryColor
                                      : Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Content Section
          Expanded(
            child: Obx(() {
              if (con.isLibraryLoading.value) {
                return ChapterListSkeleton();
              }

              return SingleChildScrollView(
                child: Column(
                  children: con.enrolledCourses.map((course) {
                    return LibraryContainer(
                      label: course.courseName,
                      onTap: () {
                        Get.toNamed(Routes.CHAPTER_SCREEN_ROUTE,
                            arguments: course);
                      },
                    );
                  }).toList(),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
