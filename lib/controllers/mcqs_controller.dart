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
  final ChapterController chapterController = Get.find<ChapterController>();

  Future<void> getSubjectNames() async {
    try {
      isSubjectLoading.value = true;
      final data = await FirestoreService().getAllDocumentNames('mcqs');
      print(data);
      subjects.assignAll(data);
    } catch (e) {
      print(e);
    } finally {
      isSubjectLoading.value = false;
    }
  }

  void increasePageNumber() {
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
      if (chapterController.selectedMcqsTopic.value.isNotEmpty) {
        selectedSubject.value = chapterController.selectedMcqsTopic.value;
      }
      isMcqsLoading.value = true;
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
