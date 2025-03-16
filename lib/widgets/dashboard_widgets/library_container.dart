import 'package:flutter/material.dart';
import 'package:prime_app/config/config.dart';

class LibraryContainer extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const LibraryContainer({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        padding:
            EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Added padding
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromRGBO(0, 0, 0, 0.085),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 20), // Adjust spacing
              child: Text(
                "${label[0]}",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: Config.FONT_FAMILY,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: Config.FONT_FAMILY,
                  color: Config.GREY_COLOR,
                  fontSize: 19,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
