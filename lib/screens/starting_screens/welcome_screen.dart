import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/loginScreen_controller.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/widgets/appButton.dart';
import 'package:prime_app/widgets/loading_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginscreenController con = Get.put(LoginscreenController());

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Gradient Background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.31, 1],
                  colors: [
                    Color.fromRGBO(5, 91, 90, 1),
                    Color.fromRGBO(7, 172, 171, 1),
                  ],
                ),
              ),
            ),

            // Image
            Positioned.fill(
              child: Image.asset(
                "assets/images/bg.png",
                fit: BoxFit.cover,
              ),
            ),

            // Content
            Column(
              children: [
                // Logo Container
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        right: 22,
                        bottom: 9,
                      ),
                      height: 132,
                      width: 132,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.08),
                            offset: Offset(-5, -5),
                            blurRadius: 0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(112),
                        ),
                      ),
                      child: Image.asset(
                        "assets/images/prime_logo.png",
                        scale: 2,
                      ),
                    )
                  ],
                ),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Welcome Box
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 32),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Welcome!",
                                style: TextStyle(
                                  fontFamily: Config.FONT_FAMILY,
                                  color: const Color.fromRGBO(221, 138, 35, 1),
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 20),
                              _buildButton(
                                context,
                                text: "Get Started",
                                onPressed: () async {
                                  await con.loginAsGuest();
                                },
                                isLoading: con.isLoading,
                              ),
                              const SizedBox(height: 20),
                              _buildButton(
                                context,
                                text: "I already have an account",
                                onPressed: () {
                                  Get.offAllNamed(Routes.SIGNUP_SCREEN_ROUTE);
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Bottom Image (Flexible prevents overflow)
                Flexible(
                  fit: FlexFit.loose,
                  child: Image.asset(
                    "assets/images/welcome_bot.png",
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required String text,
      required VoidCallback onPressed,
      RxBool? isLoading}) {
    return Container(
      height: 56,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 22),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        onPressed: onPressed,
        child: (isLoading != null && isLoading.value)
            ? const BarLoading(color: Colors.white, barHeight: 4, barWidth: 6)
            : Text(
                text,
                style: TextStyle(
                  fontFamily: Config.FONT_FAMILY,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
      ),
    );
  }
}
