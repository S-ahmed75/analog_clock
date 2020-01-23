import 'dart:math';

import 'package:flutter/material.dart';

class MinuteHandPainter extends CustomPainter {
  final Paint minuteHandPaint;
  int minutes;
  int seconds;

  MinuteHandPainter({this.minutes, this.seconds})
      : minuteHandPaint = new Paint() {
    minuteHandPaint.color = Color(0xFFD7CCC8);
    minuteHandPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    canvas.save();

    canvas.translate(radius, radius);

    canvas.rotate(2 * pi * ((this.minutes + (this.seconds / 60)) / 60));

    Path path = new Path();
    path.moveTo(-.5, -radius + radius / 10);
    path.lineTo(-8.0, -radius + radius / 2);
    path.lineTo(-1.5, 2.0);
    path.lineTo(0.4, 0.0);
    path.lineTo(7.0, -radius / 1.8);
    path.close();

    canvas.drawPath(path, minuteHandPaint);
    canvas.drawShadow(path, Colors.black, 3, false);

    canvas.restore();
  }

  @override
  bool shouldRepaint(MinuteHandPainter oldDelegate) {
    return true;
  }
}
