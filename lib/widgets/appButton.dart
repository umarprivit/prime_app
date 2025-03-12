import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/widgets/loading_widget.dart';

class Appbutton extends StatelessWidget {
  final String text;
  final onPressed;
  var isLoading;
  Appbutton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            backgroundColor: Theme.of(context).primaryColor),
        onPressed: onPressed,
        child: Text(
          "$text",
          style: TextStyle(
              fontFamily: Config.FONT_FAMILY,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 17),
        ));
  }
}
