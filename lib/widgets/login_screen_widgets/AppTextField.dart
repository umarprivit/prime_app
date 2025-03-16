import 'package:flutter/material.dart';
import 'package:prime_app/config/config.dart';

class Apptextfield extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;


  const Apptextfield(
      {super.key,
      required this.label,
      required this.hint,
      required this.controller,
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Name",
            style: TextStyle(
              height: 1.5,
              fontSize: 14,
              fontFamily: Config.FONT_FAMILY,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(82, 82, 82, 1),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(242, 242, 242, 1), // Light grey background
              borderRadius: BorderRadius.circular(9), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.30),
                  blurRadius: 4,
                  offset: Offset(0, 4), // Subtle bottom shadow
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter your name",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          // TextField(
          //   decoration: InputDecoration(
          //     hintText: "Enter your name",
          //   ),
          // ),
        ],
      ),
    );
  }
}
