import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/signUpScreen_controller.dart';

class Phonefield extends StatelessWidget {
  const Phonefield({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SignupscreenController con = Get.find<SignupscreenController>();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Phone Number",
              style: TextStyle(
                height: 1.5,
                fontSize: 14,
                fontFamily: Config.FONT_FAMILY,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(82, 82, 82, 1),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(242, 242, 242, 1),
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.30),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    alignment: Alignment.center,
                    value: con.countryCode.value,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                    style: TextStyle(
                      color: const Color.fromARGB(255, 75, 75, 75),
                    ),
                    underline: SizedBox(),
                    onChanged: (String? newValue) {
                      con.countryCode.value = newValue!;
                    },
                    items: con.countryCodes
                        .map<DropdownMenuItem<String>>((dynamic value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(242, 242, 242, 1),
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.30),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Enter Phone number",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // TextField(
            //   decoration: InputDecoration(
            //     hintText: "Enter your name",
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
