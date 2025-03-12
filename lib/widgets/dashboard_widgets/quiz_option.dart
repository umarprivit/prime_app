import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/questions_controller.dart';

class QuizOption extends StatelessWidget {
  final String label;
  final onTap;
  final isSequenced;
  final option;

  const QuizOption(
      {super.key,
      required this.label,
      required this.onTap,
      this.isSequenced = false,
      this.option});

  @override
  Widget build(BuildContext context) {
    QuestionsController con = Get.find<QuestionsController>();
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        ()=> Container(
          height: 85,
          
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
            border: con.selectedAnswer==label ? Border.all(color: Theme.of(context).primaryColor, width: 2) : null,
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromRGBO(0, 0, 0, 0.085),
            boxShadow: [],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  isSequenced ? "${option}" : "${label[0]}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: Config.FONT_FAMILY,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Expanded(
                child: Text(
                  "$label",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: Config.FONT_FAMILY,
                      color: Config.GREY_COLOR,
                      fontSize: 19),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
