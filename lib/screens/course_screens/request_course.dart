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
  RequestCourse({super.key}) {}

  DashboardController con = Get.find<DashboardController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              top: 20,
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
                    SizedBox(height: 50),
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
                            // Get.snackbar(
                            //     "Demo not available", "Demo not available",
                            //     snackPosition: SnackPosition.TOP,
                            //     backgroundColor: Colors.white);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.attach_money,
                                color: Theme.of(context).primaryColor,
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Only for ${con.selectedSkill.value.price} PKR ",
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
                              infoGatheringBottomSheet(context);
                            },
                            child: Obx(
                              () => con.isLoading.value
                                  ? BarLoading(
                                      color: Theme.of(context).primaryColor,
                                      barHeight: 4,
                                      barWidth: 6,
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.vpn_key_sharp,
                                            color: Colors.amber, size: 30),
                                        SizedBox(width: 10),
                                        Text(
                                          "Go Premium",
                                          style: TextStyle(
                                              fontFamily: Config.FONT_FAMILY,
                                              fontWeight: FontWeight.w700,
                                              color: Theme.of(context)
                                                  .primaryColor,
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
      ),
    );
  }

  void infoGatheringBottomSheet(BuildContext context) {
    con.cityController.text = con.selectedSkill.value.price!;
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Add Topic",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: Config.FONT_FAMILY,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(con.nameController, "Name"),
              const SizedBox(height: 20),
              _buildTextField(con.phoneNumberController, "Phone Number"),
              const SizedBox(height: 20),
              _buildTextField(con.cityController, "Price",
                  readOnly: true), // Make price read-only
              const SizedBox(height: 20),
              _buildTextField(con.DOBController, "Transaction ID"),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 45),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    if (!_isValidPakistaniNumber(
                        con.phoneNumberController.text)) {
                      Get.snackbar(
                          "Error", "Please enter a valid Pakistani number",
                          backgroundColor: Colors.red);
                      return;
                    }

                    if (con.nameController.text.isNotEmpty &&
                        con.phoneNumberController.text.isNotEmpty) {
                      Get.back();
                      con.requestCourse();
                    } else {
                      Get.snackbar("Error", "Please fill all the fields",
                          backgroundColor: Colors.red);
                    }
                  },
                  child: Text(
                    "Send",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: Config.FONT_FAMILY,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isValidPakistaniNumber(String number) {
    RegExp regex = RegExp(r'^(?:\+92|92|03)[0-9]{9}$');
    return regex.hasMatch(number);
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {bool readOnly = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly, // Prevent editing for price field
        keyboardType:
            hint == "Phone Number" ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
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
