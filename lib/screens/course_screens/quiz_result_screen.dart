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
          onPressed: () {
            Get.back();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png', // Change to your actual asset path
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button

                const SizedBox(height: 10),

                // Note Section
                const Text(
                  "RESULT:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Text(
                  "These results are not mantained by the Prime app. Take Screenshot for your record:",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),

                const SizedBox(height: 30),

                // Instructions List
                InstructionBullet(
                    text: "Correct answers are ${con.correct.value}"),
                InstructionBullet(
                    text: "Incorrect answers are ${con.incorrect.value}"),
                InstructionBullet(
                    text: "Skipped questions are ${con.skip.value}"),
                InstructionBullet(
                    text: "Total questions are ${con.questions.length + 1}"),

                const Spacer(), // Push button to the bottom

                // Start Test Button
                Center(
                  child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Appbutton(
                          text: "Close Quiz",
                          onPressed: () {
                            // Set your quiz ID here
                            Get.back();
                          })),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.circle,
              size: 12, color: Colors.teal), // Bullet point
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 19,
                  color: Colors.black87,
                  fontFamily: Config.FONT_FAMILY,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
