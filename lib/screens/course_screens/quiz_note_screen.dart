import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/questions_controller.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/widgets/appButton.dart';

class QuizInstructionsScreen extends StatelessWidget {
  const QuizInstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QuestionsController con = Get.put(QuestionsController());
    con.wrongQuestions.clear();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
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
                  "NOTE:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),

                // Instructions List
                const InstructionBullet(text: "Select the correct answer"),
                const InstructionBullet(text: "Submit and check answer key"),
                const InstructionBullet(text: "Try to attempt all questions"),
                const InstructionBullet(text: "If need any help contact us"),
                const InstructionBullet(
                    text: "Must solve and share with your friends"),

                const Spacer(), // Push button to the bottom

                // Start Test Button
                Center(
                  child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Appbutton(
                          text: "Start Test",
                          onPressed: () {
                            // Set your quiz ID here

                            Get.offNamed(Routes.QUIZ_SCREEN_ROUTE,
                                arguments: Get.arguments);
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
