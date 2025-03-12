import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/chapter_controller.dart';
import 'package:prime_app/controllers/dashboard_controller.dart';
import 'package:prime_app/controllers/video_controller.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/widgets/dashboard_widgets/library_container.dart';
import 'package:prime_app/widgets/shimmering_skeltons/library_container_skelton.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChapterController con = Get.find<ChapterController>();
    final DashboardController con1 = Get.find<DashboardController>();
    con.fetchTopics();
    return Scaffold(
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
          children: [
            const SizedBox(height: 10),

            // Chapter Name Widget
            Container(
              height: 85,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 30),
                  const Icon(Icons.article_rounded, color: Colors.white),
                  const SizedBox(width: 40),
                  Text(
                    "${con.selectedChapter.chapterName}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: Config.FONT_FAMILY,
                      color: Colors.white,
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
            ),

            // Topic Container with fixed height

            Expanded(
              child: Obx(() {
                if (con.isTopicLoading.value) {
                  return Center(child: ChapterListSkeleton());
                }
                if (con.topicsList.isEmpty) {
                  return Center(
                    child: Text(
                      "No Topics available",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  itemCount: con.topicsList.length,
                  itemBuilder: (context, index) {
                    return LibraryContainer(
                      onTap: () {
                        if (con1.isLearnSelected.value) {
                          if (con.topicsList[index].link == "none") {
                            Get.snackbar("No Video Available",
                                "Please try another topic");
                            return;
                          }
                          final vidCon = Get.put(VideoController());
                          vidCon.topicName.value =
                              con.topicsList[index].topicName;
                          vidCon.videoUrl.value = con.topicsList[index].link;
                          Get.toNamed(Routes.VIDEO_SCREEN_ROUTE);
                        } else {
                          Get.toNamed(Routes.QUIZ_INSTRUCTION_SCREEN_ROUTE,
                              arguments: con.topicsList[index].quizId);
                        }
                      },
                      label: con.topicsList[index].topicName as String,
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
