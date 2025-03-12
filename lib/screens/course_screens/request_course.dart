import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/dashboard_controller.dart';
import 'package:prime_app/controllers/loginScreen_controller.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/screens/starting_screens/login_screen.dart';
import 'package:prime_app/widgets/appButton.dart';
import 'package:prime_app/widgets/loading_widget.dart';

class RequestCourse extends StatelessWidget {
  const RequestCourse({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController con = Get.find<DashboardController>();
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

          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Get.back();
              },
            ),
          ),

          //Center Widget
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(height: 50),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 56,
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 39, right: 39),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            backgroundColor: Colors.white),
                        onPressed: () async {
                          Get.snackbar(
                              "Demo not available", "Demo not available",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.white);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.vpn_key_rounded,
                              color: Theme.of(context).primaryColor,
                              size: 30,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Watch Demo",
                              style: TextStyle(
                                  fontFamily: Config.FONT_FAMILY,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 17),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(height: 20),
                  Container(
                      height: 56,
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 39, right: 39),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              backgroundColor: Colors.white),
                          onPressed: () async {
                            await con.requestCourse();
                          },
                          child: Obx(
                            () => con.isLoading.value
                                ? BarLoading(
                                    color: Theme.of(context).primaryColor,
                                    barHeight: 4,
                                    barWidth: 6,
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.vpn_key_sharp,
                                          color: Colors.amber, size: 30),
                                      SizedBox(width: 10),
                                      Text(
                                        "Go Premium",
                                        style: TextStyle(
                                            fontFamily: Config.FONT_FAMILY,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 17),
                                      ),
                                    ],
                                  ),
                          ))),
                ],
              ),
              SizedBox(height: 20),
              //Bottom Image
              Container(
                margin: EdgeInsets.only(top: 32),
                child: Image.asset(
                  "assets/images/request_robot.png",
                  scale: 1.8,
                ),
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
