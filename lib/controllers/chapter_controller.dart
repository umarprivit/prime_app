import 'package:get/get.dart';
import 'package:prime_app/controllers/mcqs_controller.dart';
import 'package:prime_app/models/chapter_model.dart';
import 'package:prime_app/models/course_model.dart';
import 'package:prime_app/models/topic_model.dart';
import 'package:prime_app/service/firestore_service.dart';

class ChapterController extends GetxController {
  var chapterList = [].obs;
  var topicsList = [].obs;
  RxString selectedMcqsTopic = ''.obs;
  RxString selectedTopicId = ''.obs;

  var isLoading = false.obs;
  RxBool isTopicLoading = false.obs;
  late Course selectedCourse;
  late Chapter selectedChapter;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchChapter() async {
    try {
      isLoading.value = true;
      final chapters =
          await FirestoreService().getChaptersArray(selectedCourse.id);
      print("I am Chapters");
      if (!chapters.isEmpty) {
        List<Chapter> sortedChapters = [];
        Chapter? mcqsChapter;

        for (var e in chapters) {
          if (e['id'] == "MCQSSS") {
            selectedMcqsTopic.value = e['chapterName'];
            mcqsChapter = Chapter.fromJson({
              "id": "MCQSSS",
              "chapterName": "MCQS & Past Papers",
            }); // Store MCQSSS separately
          } else {
            sortedChapters
                .add(Chapter.fromJson(e)); // Add other chapters normally
          }
        }

        if (mcqsChapter != null) {
          sortedChapters.insert(0, mcqsChapter);
        }

// Assign the sorted list to chapterList
        chapterList.assignAll(sortedChapters);
      } else {
        chapterList.clear();
      }
    } catch (e) {
      print("Error fetching chapters: $e");
    } finally {
      isLoading(false);
    }
  }

  void fetchTopics() async {
    try {
      isTopicLoading.value = true;
      final topics = await FirestoreService()
          .getTopicsArray(selectedCourse.id, selectedChapter.id as String);
      print(topics);
      print("I am Topics");
      if (!topics.isEmpty) {
        topicsList.clear();
        topicsList.assignAll(topics.map((e) {
          print(e);
          return Topic.fromJson(e);
        }).toList());
      }
    } catch (e) {
      print("Error fetching Topics: $e");
    } finally {
      isTopicLoading(false);
    }
  }
}
