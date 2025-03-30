import 'package:get/get.dart';
import 'package:prime_app/controllers/chapter_controller.dart';
import 'package:prime_app/models/question_model.dart';
import 'package:prime_app/service/firestore_service.dart';

class McqsController extends GetxController {
  RxString selectedSubject = ''.obs;
  RxList subjects = [].obs;
  RxList<QuizQuestion> mcqs = <QuizQuestion>[].obs;
  RxBool isSubjectLoading = false.obs;
  RxBool isMcqsLoading = false.obs;
  RxInt selectedPageNumber = 1.obs;
  RxString totalPageNumber = "".obs;
  final ChapterController chapterController = Get.find<ChapterController>();
  // final ChapterController chapterController =
  //     Get.put(ChapterController());

  Future<void> getTotalPageNumber() async {
    try {
      final data = await FirestoreService()
          .getFieldFromDocument("mcqs", selectedSubject.value, "total_page");

      if (data != null) {
        totalPageNumber.value = data.toString();
        print(data);
      } else {
        totalPageNumber.value = selectedPageNumber.value.toString();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getSubjectNames() async {
    try {
      if (chapterController.selectedMcqsTopic.value.isNotEmpty) {
        // Split the string and add unique subjects to the list
        List<String> selectedSubjects =
            chapterController.selectedMcqsTopic.value
                .split(',')
                .map((e) => e.trim().toLowerCase()) // Trim spaces
                .toList();

        // Assign subjects without fetching from Firestore
        subjects.assignAll(selectedSubjects);
        print("Subjects from selectedMcqsTopic: $subjects");
        return; // Exit the function early
      }

      isSubjectLoading.value = true;

      // Fetch subjects from Firestore
      final data = await FirestoreService().getAllDocumentNames('mcqs');
      print("Raw Data from Firestore: $data");

      // Split Firestore data and assign to subjects
      List<String> separatedSubjects = [];

      for (String entry in data) {
        separatedSubjects.addAll(entry.split(',').map((e) => e.trim()));
      }

      subjects.assignAll(separatedSubjects);
      print("Processed Subjects from Firestore: $subjects");
    } catch (e) {
      print("Error: $e");
    } finally {
      isSubjectLoading.value = false;
    }
  }

  void increasePageNumber() {
    if (selectedPageNumber.value >= int.parse(totalPageNumber.value)) {
      return;
    }
    selectedPageNumber.value++;
    getAllMcqs();
  }

  void decreasePageNumber() {
    if (selectedPageNumber > 1) {
      selectedPageNumber.value--;
      getAllMcqs();
    }
  }

  Future<void> getAllMcqs() async {
    try {
      mcqs.clear();

      isMcqsLoading.value = true;
      if(selectedSubject.value == "error detection"){
        selectedSubject.value = "error Detection";
      }
      final data = await FirestoreService().getFieldFromDocument(
        'mcqs',
        selectedSubject.value,
        selectedPageNumber.value.toString(),
      );
      mcqs.value = List<QuizQuestion>.from(
        data.map((e) => QuizQuestion.fromMap(e)),
      );
    } catch (e) {
      print(e);
    } finally {
      isMcqsLoading.value = false;
    }
  }
}
