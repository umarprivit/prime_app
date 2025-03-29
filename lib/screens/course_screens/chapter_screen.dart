import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/chapter_controller.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/widgets/dashboard_widgets/library_container.dart';
import 'package:prime_app/widgets/shimmering_skeltons/library_container_skelton.dart';

class ChapterScreen extends StatelessWidget {
  const ChapterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChapterController con = Get.put(ChapterController());
    con.selectedCourse = Get.arguments;
    con.fetchChapter();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),

              // Course Name Widget
              Column(
                children: [
                  Container(
                    height: 85,
                    width: 85,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "${con.selectedCourse.courseName[0]}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: Config.FONT_FAMILY,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${con.selectedCourse.courseName}",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Config.GREY_COLOR,
                      fontFamily: Config.FONT_FAMILY,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Chapter List
              Expanded(
                child: Obx(() {
                  if (con.isLoading.value) {
                    return Center(child: ChapterListSkeleton());
                  }
                  if (con.chapterList.isEmpty) {
                    return Center(
                      child: Text(
                        "No chapters available",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: con.chapterList.length,
                    itemBuilder: (context, index) {
                      return LibraryContainer(
                        onTap: () {
                          if (con.chapterList[index].chapterName == "MCQS") {
                            con.selectedChapter = con.chapterList[index];
                            Get.toNamed(Routes.MCQS_SCREEN_ROUTE);
                            return;
                          }
                          con.selectedChapter = con.chapterList[index];
                          Get.toNamed(Routes.TOPICS_SCREEN_ROUTE);
                        },
                        label: con.chapterList[index].chapterName as String ??
                            "Chapter",
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
