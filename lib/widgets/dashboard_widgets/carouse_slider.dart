import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/controllers/dashboard_controller.dart';

class CarouselScreen extends StatefulWidget {
  @override
  _CarouselScreenState createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  final CarouselSliderController carouselController =
      CarouselSliderController();
  final CarouselSliderController popupCarouselController =
      CarouselSliderController();
  final DashboardController con = Get.find<DashboardController>();

  void _showImagePopup(int index) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allows tapping outside to dismiss
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.pop(context), // Close dialog on tap
          child: Dialog(
            backgroundColor: Colors.black.withOpacity(0.9),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CarouselSlider.builder(
              itemCount: con.carouselImages.length,
              itemBuilder: (context, index, realIndex) {
                return GestureDetector(
                  onTap: () => _showImagePopup(index),
                  child: Image.asset(con.carouselImages[index], fit: BoxFit.cover),
                );
              },
              options: CarouselOptions(viewportFraction: 1),
              carouselController: carouselController,
            ),
          ),
        ],
      ),
    );
  }
}
