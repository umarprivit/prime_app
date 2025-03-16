import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/questions_controller.dart';

class QuizOption extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSequenced;
  final String? option;

  const QuizOption({
    super.key,
    required this.label,
    required this.onTap,
    this.isSequenced = false,
    this.option,
  });

  @override
  Widget build(BuildContext context) {
    QuestionsController con = Get.find<QuestionsController>();

    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () => Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          padding: const EdgeInsets.all(15), // Padding for better spacing
          decoration: BoxDecoration(
            border: con.selectedAnswer == label
                ? Border.all(color: Theme.of(context).primaryColor, width: 2)
                : null,
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromRGBO(0, 0, 0, 0.085),
          ),
          child: IntrinsicHeight(
            // Allows the container to expand based on content
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Option Prefix
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 15),
                  child: Text(
                    isSequenced ? option ?? "" : label[0],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: Config.FONT_FAMILY,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),

                // Expanded Text
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: Config.FONT_FAMILY,
                      color: Config.GREY_COLOR,
                      fontSize: 19,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
