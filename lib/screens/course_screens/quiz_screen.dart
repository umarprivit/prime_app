import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/questions_controller.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/widgets/appButton.dart';
import 'package:prime_app/widgets/dashboard_widgets/question.dart';
import 'package:prime_app/widgets/dashboard_widgets/quiz_option.dart';
import 'package:prime_app/widgets/loading_widget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    final con = Get.put(QuestionsController());
    con.quizId.value = Get.arguments[0];
    con.chapterId = Get.arguments[1];
    con.fetchQuiz();
  }

  void _nextQuestion(QuestionsController con) {
    if (con.count.value < con.questions.length - 1) {
      con.count.value++;
      con.selectedAnswer.value = ""; // Reset answer selection
    } else {
      Get.offNamed(Routes.QUIZ_RESULT_SCREEN_ROUTE);
    }
  }

  @override
  Widget build(BuildContext context) {
    final con = Get.find<QuestionsController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.055),
        centerTitle: true,
        title: Text(
          "Intro to Biology",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Config.GREY_COLOR,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: Config.FONT_FAMILY,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.09)),
        height: 80,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(con.questions.length, (index) {
              return Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(vertical: 15),
                width: 80,
                decoration: BoxDecoration(
                  border: con.count.value == index
                      ? Border(
                          top: BorderSide(
                              color: Theme.of(context).primaryColor, width: 3))
                      : null,
                ),
                child: Text(
                  "${index + 1}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    fontFamily: Config.FONT_FAMILY,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(
          () => con.isLoading.value
              ? BarLoading(color: Theme.of(context).primaryColor)
              : con.questions.isEmpty
                  ? Center(child: Text("No Quiz Available for the moment"))
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          QuestionBanner(
                              text: "Question ${con.count.value + 1}"),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Text(
                              con.questions[con.count.value].question,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: Config.FONT_FAMILY,
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Column(children: [
                            ...con.questions[con.count.value].options
                                .map((item) {
                              return QuizOption(
                                label: "${item}",
                                onTap: () {
                                  print(item);
                                  con.selectedAnswer.value = item;
                                },
                                isSequenced: true,
                                option:
                                    "${con.questions[con.count.value].options.indexOf(item) + 1}",
                              );
                            })
                          ]),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 150,
                                height: 50,
                                child: Appbutton(
                                  text: "Submit",
                                  onPressed: () {
                                    if (con.selectedAnswer.value.isEmpty) {
                                      Get.snackbar(
                                          "Alert", "Please select an option",
                                          snackPosition: SnackPosition.BOTTOM);
                                      return;
                                    }

                                    if (con.selectedAnswer.value ==
                                        con.questions[con.count.value]
                                            .correct) {
                                      con.correct.value++;
                                    } else {
                                      con.incorrect.value++;
                                    }

                                    _nextQuestion(con);
                                  },
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 50,
                                child: Appbutton(
                                  text: "Skip",
                                  onPressed: () {
                                    con.skip.value++;
                                    _nextQuestion(con);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
