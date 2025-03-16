import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/signUpScreen_controller.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/widgets/appButton.dart';
import 'package:prime_app/widgets/login_screen_widgets/AppTextField.dart';
import 'package:prime_app/widgets/login_screen_widgets/dropdownFields.dart';
import 'package:prime_app/widgets/login_screen_widgets/password_field.dart';
import 'package:prime_app/widgets/login_screen_widgets/phone_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SignupscreenController con = Get.put(SignupscreenController());
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        //     onPressed: () {
        //       Get.offAllNamed(Routes.WELCOME_SCREEN_ROUTE);
        //     },
        //   ),
        // ),
        resizeToAvoidBottomInset: true,
        body:

            // Background Image
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                  child: Image.asset(
                                "assets/images/prime_logo.png",
                                scale: 1.2,
                              )),
                              Text(
                                "REGISTER",
                                style: TextStyle(
                                  fontSize: 26,
                                  letterSpacing: 0.75,
                                  fontFamily: Config.FONT_FAMILY,
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromRGBO(53, 53, 53, 1),
                                ),
                              ),
                              Text(
                                "Let's get started",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: Config.FONT_FAMILY,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(53, 53, 53, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Apptextfield(
                          label: "Name",
                          hint: "Enter your name",
                          controller: con.emailController,
                        ),
                        SizedBox(height: 10),
                        // Phone number fields
                        Phonefield(),
                        SizedBox(height: 10),
                        // Password Fields
                        PasswordField(),
                        SizedBox(height: 10),
                        // City and interests
                        CityInterestsField(),
                        SizedBox(height: 12),
                        // Terms and conditions
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Terms and conditions, ",
                                style: TextStyle(
                                    fontFamily: Config.FONT_FAMILY,
                                    color: Color.fromRGBO(82, 82, 82, 1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              GestureDetector(
                                child: Text(
                                  "Here",
                                  style: TextStyle(
                                      fontFamily: Config.FONT_FAMILY,
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),

                        SizedBox(height: 12),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 39),
                            height: 55,
                            width: double.infinity,
                            child: Appbutton(
                                text: "Create an account", onPressed: () {})),
                        SizedBox(height: 12),
                        // Center linee
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 36),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Color.fromRGBO(4, 121, 119, 0.5))),
                        ),
                        SizedBox(height: 12),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 39),
                          height: 40,
                          width: double.infinity,
                          child: Appbutton(
                              text: "Already have an account? Login",
                              onPressed: () {
                                Get.offAllNamed(Routes.LOGIN_SCREEN_ROUTE);
                              }),
                        )
                      ],
                    ),
                  ),
                )));
  }
}
