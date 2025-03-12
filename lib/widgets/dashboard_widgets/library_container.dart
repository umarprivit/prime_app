import 'package:flutter/material.dart';
import 'package:prime_app/config/config.dart';

class LibraryContainer extends StatelessWidget {
  final String label;
  final onTap;

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
        
        height: 85,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromRGBO(0, 0, 0, 0.085),
          boxShadow: [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Text(
                "${label[0]}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: Config.FONT_FAMILY,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Expanded(
              child: Text(
                "$label",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: Config.FONT_FAMILY,
                    color: Config.GREY_COLOR,
                    fontSize: 19),
              ),
            )
          ],
        ),
      ),
    );
  }
}
