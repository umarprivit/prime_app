import 'package:flutter/material.dart';
import 'package:prime_app/config/config.dart';

class QuestionBanner extends StatelessWidget {
  final String text;

  const QuestionBanner({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BannerClipper(),
      child: Container(
        width: 200,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        color: Theme.of(context).primaryColor, // Teal color
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.assignment, color: Colors.white, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BannerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height); // Start from bottom-left
    path.lineTo(size.width, size.height); // Bottom-right minus arrow space
    path.lineTo(
        size.width - 20, size.height / 2); // Bottom-right minus arrow space
    // path.lineTo(size.width, size.height / 2); // Arrow tip (middle-right)
    path.lineTo(size.width, 0); // Top-right minus arrow space
    path.lineTo(0, 0); // Top-left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
