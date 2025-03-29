import 'package:get/get.dart';
import 'package:prime_app/models/question_model.dart';
import 'package:prime_app/service/firestore_service.dart';

class QuestionsController extends GetxController {
  RxList questions = [].obs;
  RxInt count = 0.obs;
  RxInt correct = 0.obs;
  RxInt incorrect = 0.obs;
  RxInt skip = 0.obs;
  RxString selectedAnswer = "".obs;
  RxBool isLoading = false.obs;
  RxString quizId = "".obs;
  String chapterId = "";
  List<Map<dynamic, dynamic>> wrongQuestions = [];
  final jsson = [];

  void fetchQuiz() async {
    try {
      if (quizId.value == 'none') {
        return;
      }
      print(chapterId);
      print(quizId.value);
      isLoading.value = true;
      final question =
          await FirestoreService().getQuizArray(chapterId, quizId.value);
      print(question);
      print("I am QUiz");
      if (!question.isEmpty) {
        questions.clear();
        questions.assignAll(question.map((e) {
          print(e);
          return QuizQuestion.fromMap(e);
        }).toList());
      }
    } catch (e) {
      print("Error fetching Quiz: $e");
    } finally {
      isLoading(false);
    }
  }
}
