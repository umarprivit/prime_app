import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/controllers/chapter_controller.dart';
import 'package:prime_app/controllers/mcqs_controller.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/widgets/dashboard_widgets/library_container.dart';
import 'package:prime_app/widgets/shimmering_skeltons/library_container_skelton.dart';

class McqsSubjectScreen extends StatefulWidget {
  McqsSubjectScreen({super.key});

  @override
  State<McqsSubjectScreen> createState() => _McqsSubjectScreenState();
}

class _McqsSubjectScreenState extends State<McqsSubjectScreen> {
  final McqsController con = Get.put(McqsController());
  ChapterController con1 = Get.find<ChapterController>();

  @override
  void initState() {
    super.initState();
    con.getSubjectNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(con1.selectedCourse.courseName),
      ),
      body: Obx(
        () => con.isSubjectLoading.value
            ? ChapterListSkeleton()
            : con.subjects.isEmpty
                ? Center(child: Text("No MCQs available at the moment"))
                : ListView.builder(
                    itemCount: con.subjects.length,
                    itemBuilder: (context, index) {
                      return LibraryContainer(
                          label: "${con.subjects[index]}".capitalize!,
                          onTap: () {
                            con.selectedPageNumber.value = 1;
                            con.selectedSubject.value = con.subjects[index];

                            Get.toNamed(Routes.MCQS_SCREEN_ROUTE);
                          });
                    }),
      ),
    );
  }
}
