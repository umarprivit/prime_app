import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/questions_controller.dart';
import 'package:prime_app/widgets/appButton.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionsController con = Get.find<QuestionsController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png', // Ensure the correct asset path
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "RESULT:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Text(
                  "These results are not maintained by the Prime app. Take a screenshot for your record:",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),

                const SizedBox(height: 30),

                // Instructions List
                InstructionBullet(
                    text: "Correct answers: ${con.correct.value}"),
                InstructionBullet(
                    text: "Incorrect answers: ${con.incorrect.value}"),
                InstructionBullet(
                    text: "Skipped questions: ${con.skip.value}"),
                InstructionBullet(
                    text: "Total questions: ${con.questions.length}"),

                const SizedBox(height: 20),

                // Wrong Answers List
                Expanded(
                  child: ListView.builder(
                    itemCount: con.wrongQuestions.length,
                    itemBuilder: (context, index) {
                      final questionData = con.wrongQuestions[index];

                      return Container(
                        padding: const EdgeInsets.all(14),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${index + 1}. ${questionData['question']}",
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColor,
                                fontFamily: Config.FONT_FAMILY,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...questionData['options'].map<Widget>((e) {
                              return Text(
                                "${questionData['options'].indexOf(e) + 1}. $e",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: e == questionData['correct']
                                      ? Colors.green
                                      : e == questionData['selected']
                                          ? Colors.red
                                          : Colors.black,
                                  fontWeight: e == questionData['correct']
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

                const SizedBox(height: 20),

                // Close Quiz Button
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Appbutton(
                      text: "Close Quiz",
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom widget for bullet points
class InstructionBullet extends StatelessWidget {
  final String text;
  const InstructionBullet({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 12, color: Colors.teal),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 19,
                color: Colors.black87,
                fontFamily: Config.FONT_FAMILY,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
