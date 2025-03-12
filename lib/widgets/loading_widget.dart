import 'package:flutter/material.dart';
import 'dart:math';

class BarLoading extends StatefulWidget {
  final Color color;
  final double barWidth;
  final double barHeight;
  final int barCount;
  final Duration duration;

  const BarLoading({
    super.key,
    this.color = Colors.blue,
    this.barWidth = 8.0,
    this.barHeight = 20.0,
    this.barCount = 4,
    this.duration = const Duration(milliseconds: 2000), // Smooth speed
  });

  @override
  _BarLoadingState createState() => _BarLoadingState();
}

class _BarLoadingState extends State<BarLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.barCount, (index) {
              double progress =
                  (_controller.value * 2 * pi) + (index * pi / widget.barCount);
              double height =
                  widget.barHeight * (0.5 + 0.5 * sin(progress)).abs();

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: widget.barWidth,
                height: height,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
