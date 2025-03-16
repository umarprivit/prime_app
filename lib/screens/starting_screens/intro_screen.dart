import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/loginScreen_controller.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/widgets/appButton.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // White backgroudn
          Container(
            color: Colors.white,
          ),

          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Center(
            child: Image.asset("assets/images/prime_logo.png"),
          ),

          Positioned(
            bottom: 50,
            left: 115,
            right: 115,
            child: Container(
                width: 153,
                height: 47,
                child: Appbutton(
                    text: "LET'S START",
                    onPressed: () {
                      Get.offAllNamed(Routes.BANNER_SCREEN_ROUTE);
                    })),
          ),
        ],
      ),
    );
  }
}
