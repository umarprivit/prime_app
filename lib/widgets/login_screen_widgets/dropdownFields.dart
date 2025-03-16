import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/signUpScreen_controller.dart';

class CityInterestsField extends StatelessWidget {
  const CityInterestsField({super.key});

  @override
  Widget build(BuildContext context) {
    SignupscreenController con = Get.find<SignupscreenController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Interests",
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 14,
                    fontFamily: Config.FONT_FAMILY,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(82, 82, 82, 1),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(right: 4),
                  padding: EdgeInsets.symmetric(horizontal: 12),
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
                  child: Obx(
                    ()=> DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: con.choosedInterest.value,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 75, 75, 75),
                        ),
                        onChanged: (String? newValue) {
                          con.choosedInterest.value = newValue!;
                        },
                        items: con.interests
                            .map<DropdownMenuItem<String>>((dynamic value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "City",
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 14,
                    fontFamily: Config.FONT_FAMILY,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(82, 82, 82, 1),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 4),
                  padding: EdgeInsets.symmetric(horizontal: 12),
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
                  child: Obx(
                    ()=> DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: con.choosedCity.value,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 75, 75, 75),
                        ),
                        onChanged: (String? newValue) {
                          con.choosedCity.value = newValue!;
                        },
                        items: con.city
                            .map<DropdownMenuItem<String>>((dynamic value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
