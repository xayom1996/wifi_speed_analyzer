import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:wifi_speed_analyzer/theme/color_theme.dart';

class MyPainter extends CustomPainter { //         <-- CustomPainter class
  final List<Offset> points;

  MyPainter({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final pointMode = ui.PointMode.polygon;

    final paint = Paint()
      ..color = mainColor
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.translate(0, 80);
    canvas.scale(1, -0.5);
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}