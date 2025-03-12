import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/loginScreen_controller.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/screens/starting_screens/login_screen.dart';
import 'package:prime_app/widgets/appButton.dart';
import 'package:prime_app/widgets/loading_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginscreenController con = Get.put(LoginscreenController());
    return Scaffold(
      body: Stack(
        children: [
          //Gradient Background
          Container(
            decoration: BoxDecoration(
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
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          //Center Widget
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      right: 22,
                      bottom: 9,
                    ),
                    height: 132,
                    width: 132,
                    decoration: BoxDecoration(
                        //inner shadow
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
                        )),
                    //image sizer bigger
                    child: Image.asset(
                      "assets/images/prime_logo.png",
                      scale: 2,
                    ),
                  )
                ],
              ),

              // SizedBox(height: 50),
              Spacer(),

              Container(
                height: 269,
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 32,
                  right: 32,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(11),
                      topRight: Radius.circular(11),
                      bottomLeft: Radius.circular(11),
                      bottomRight: Radius.circular(0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Welcome!",
                        style: TextStyle(
                          fontFamily: Config.FONT_FAMILY,
                          color: Color.fromRGBO(221, 138, 35, 1),
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        )),
                    Container(
                        height: 56,
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 22, right: 22),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            onPressed: () async {
                              await con.loginAsGuest();
                            },
                            child: Obx(
                              () => con.isLoading.value
                                  ? BarLoading(
                                      color: Colors.white,
                                      barHeight: 4,
                                      barWidth: 6,
                                    )
                                  : Text(
                                      "Get Started",
                                      style: TextStyle(
                                          fontFamily: Config.FONT_FAMILY,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontSize: 17),
                                    ),
                            ))),
                    _buildButton("I already have an account", context, () {
                      Get.offAllNamed(Routes.SIGNUP_SCREEN_ROUTE);
                    }),
                  ],
                ),
              ),

              //Bottom Image
              Container(
                margin: EdgeInsets.only(top: 32),
                child: Image.asset("assets/images/welcome_bot.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, context, onpressed) {
    return Container(
        height: 56,
        width: double.infinity,
        margin: EdgeInsets.only(left: 22, right: 22),
        child: Appbutton(
          text: text,
          onPressed: onpressed,
        ));
  }
}
