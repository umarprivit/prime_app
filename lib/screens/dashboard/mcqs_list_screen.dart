import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/mcqs_controller.dart';
import 'package:prime_app/widgets/dashboard_widgets/mcqslist_skelton.dart';

class McqsListScreen extends StatefulWidget {
  McqsListScreen({super.key});

  @override
  State<McqsListScreen> createState() => _McqsListScreenState();
}

class _McqsListScreenState extends State<McqsListScreen> {
  final McqsController con = Get.put(McqsController());

  bool isFullScreen = false;

  final _noScreenshot = NoScreenshot.instance;

  Future<void> _disableScreenshot() async {
    bool result = await _noScreenshot.screenshotOff();
    debugPrint('Screenshot Off: $result');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _disableScreenshot();
  }

  @override
  Widget build(BuildContext context) {
    con.getAllMcqs();
    con.getTotalPageNumber();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text('${con.selectedSubject.value.capitalizeFirst} MCQs'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: con.decreasePageNumber,
              ),
              Obx(
                () => Text(
                  "${con.selectedPageNumber.value}/${con.totalPageNumber.value}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: con.increasePageNumber,
              ),
            ],
          ),
          Expanded(
            child: Obx(
              () => con.isMcqsLoading.value
                  ? McqsListSkeleton()
                  : con.mcqs.isEmpty
                      ? Center(
                          child:
                              Text("No Mcqs Available for this specific topic"),
                        )
                      : ListView.builder(
                          itemCount: con.mcqs.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(14),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(
                                        157, 126, 126, 126),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${index + 1}. ${con.mcqs[index].question}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: Config.FONT_FAMILY,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  ...con.mcqs[index].options.map((e) {
                                    return Text(
                                      "${String.fromCharCode(65 + con.mcqs[index].options.indexOf(e))}. $e", // Convert index to A, B, C, D
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: e == con.mcqs[index].correct
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                        fontFamily: Config.FONT_FAMILY,
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
