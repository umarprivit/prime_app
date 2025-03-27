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
  final CarouselSliderController popupCarouselController =
      CarouselSliderController();

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

              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Obx(
                    () => con.isHomeLoading.value
                        ? CourseGridShimmer()
                        : GridView.builder(
                            shrinkWrap: true,
                            itemCount: con.courses.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                  Get.toNamed(
                                      Routes.REQUEST_COURSE_SCREEN_ROUTE);
                                },
                              );
                            },
                          ),
                  ),
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
                    child: CarouselSlider.builder(
                      itemCount: con.carouselImages.length,
                      itemBuilder: (context, index, realIndex) {
                        return GestureDetector(
                          onTap: () => _showImagePopup(index, context),
                          child: Image.asset(
                            con.carouselImages[index],
                          ),
                        );
                      },
                      options: CarouselOptions(viewportFraction: 1),
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

  void _showImagePopup(int index, context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allows tapping outside to dismiss
      builder: (context) {
        return GestureDetector(
          onTap: () => Get.back, // Close dialog on tap
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))),
            backgroundColor: const Color.fromARGB(111, 0, 0, 0),
            insetPadding: EdgeInsets.zero,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {}, // Prevents closing when tapping the image
                  child: CarouselSlider(
                    items: con.carouselImages
                        .map(
                          (image) => InteractiveViewer(
                            child: Image.asset(image, fit: BoxFit.contain),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      initialPage: index,
                      enableInfiniteScroll: true,
                      viewportFraction: 1,
                      height: MediaQuery.of(context).size.height,
                    ),
                    carouselController: popupCarouselController,
                  ),
                ),

                // Close Button
                Positioned(
                  top: 40,
                  right: 20,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white, size: 30),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
