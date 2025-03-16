import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/loginScreen_controller.dart';
import 'package:prime_app/controllers/signUpScreen_controller.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/widgets/appButton.dart';
import 'package:prime_app/widgets/login_screen_widgets/AppTextField.dart';
import 'package:prime_app/widgets/login_screen_widgets/dropdownFields.dart';
import 'package:prime_app/widgets/login_screen_widgets/password_field.dart';
import 'package:prime_app/widgets/login_screen_widgets/phone_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginscreenController con = Get.put(LoginscreenController());
    return Scaffold(
      
      resizeToAvoidBottomInset: true,
      body:
          // White backgroudn

          // Background Image
          Container(
              decoration: BoxDecoration(
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
                            )),
                            Text(
                              "LOGIN",
                              style: TextStyle(
                                fontSize: 39,
                                letterSpacing: 0.75,
                                fontFamily: Config.FONT_FAMILY,
                                fontWeight: FontWeight.w800,
                                color: Color.fromRGBO(53, 53, 53, 1),
                              ),
                            ),
                            Text(
                              "Enter your login details",
                              style: TextStyle(
                                fontSize: 19,
                                fontFamily: Config.FONT_FAMILY,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(53, 53, 53, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 70),
                      Apptextfield(
                        label: "Email",
                        hint: "email@xyz.com",
                        controller: con.emailController,
                      ),
                      SizedBox(height: 15),
                      // Phone number fields
                      _buildPasswordField(con.passwordController),
                      SizedBox(height: 25),
                      GestureDetector(
                        onTap: () {
                          //To Do : Forgot Password
                        },
                        child: Text("Forgot password?",
                            style: TextStyle(
                                fontFamily: "Kumbh Sans",
                                color: Theme.of(context).primaryColor)),
                      ),
                      SizedBox(height: 15),
                      Container(
                          height: 53,
                          width: 138,
                          child: Appbutton(
                              text: "Login",
                              onPressed: () {
                                //To Do : Login
                              })),
                      SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //Login with google or facebook
                            GestureDetector(
                              onTap: () {
                                //To Do : Login with Google
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(242, 242, 242, 1),
                                    borderRadius: BorderRadius.circular(7),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.30),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/google.png"),
                                      SizedBox(width: 5),
                                      Text(
                                        "Continue with Google",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Kumbh Sans",
                                          color: Color.fromRGBO(82, 82, 82, 1),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            SizedBox(width: 12),
                            GestureDetector(
                              onTap: () {
                                //To Do : Login with Facebook
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(242, 242, 242, 1),
                                    borderRadius: BorderRadius.circular(7),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.30),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/facebook.png"),
                                      SizedBox(width: 5),
                                      Text(
                                        "Continue with Facebook",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Kumbh Sans",
                                          color: Color.fromRGBO(82, 82, 82, 1),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 32),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Color.fromRGBO(4, 121, 119, 0.5))),
                      ),
                      SizedBox(height: 40),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 36),
                        width: double.infinity,
                        height: 40,
                        child: Appbutton(
                            text: "New to Prime? Register",
                            onPressed: () {
                              Get.offAllNamed(Routes.SIGNUP_SCREEN_ROUTE);
                            }),
                      )
                    ],
                  ),
                ),
              )),
    );
  }

  Widget _buildPasswordField(controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Password",
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
            controller: controller,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Create Password",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        )
      ]),
    );
  }
}
