import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/controllers/dashboard_controller.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/screens/dashboard/course_widget.dart';
import 'package:prime_app/widgets/shimmering_skeltons/course_grid_shimmer.dart';

class Homescreen extends StatelessWidget {
  final CarouselSliderController carouselController =
      CarouselSliderController();
  final DashboardController con = Get.find<DashboardController>();
  Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    con.getHomePageSkills();
    return Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              //Center Content

              Obx(
                () => con.isHomeLoading.value
                    ? CourseGridShimmer()
                    : GridView.builder(
                        shrinkWrap: true,
                        itemCount: 9,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        itemBuilder: (context, index) {
                          return CourseWidget(
                            label: con.courses[index].courseName,
                            onTap: () {
                              con.selectedSkill.value = con.courses[index];
                              print(con.selectedSkill.value.courseName);
                              Get.toNamed(Routes.REQUEST_COURSE_SCREEN_ROUTE);
                            },
                          );
                        },
                      ),
              ),
              SizedBox(height: 40),

              //Carousel Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        carouselController.previousPage();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Theme.of(context).primaryColor,
                      )),
                  Expanded(
                    child: CarouselSlider(
                      items: [
                        Image.asset("assets/images/carousel_image.png"),
                        Image.asset("assets/images/carousel_image.png"),
                      ],
                      options: CarouselOptions(
                        viewportFraction: 1,
                      ),
                      carouselController: carouselController,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        carouselController.nextPage();
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryColor,
                      )),
                ],
              )
            ],
          ),
        ));
  }
}
