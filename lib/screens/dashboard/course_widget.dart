import 'package:flutter/material.dart';
import 'package:prime_app/config/config.dart';

class CourseWidget extends StatelessWidget {
  final String label;
  final onTap;
  const CourseWidget({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      // wrap with the widget that it takes the place that is required
      child: SizedBox(
        child: Column(
          children: [
            Container(
              height: 85,
              width: 85,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(label[0],
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: Config.FONT_FAMILY,
                      fontSize: 33,
                      fontWeight: FontWeight.w800,
                    )),
              ),
            ),
            Expanded(
              child: Container(
                width: 85,
                child: Text(label,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Config.GREY_COLOR,
                      fontFamily: Config.FONT_FAMILY,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
