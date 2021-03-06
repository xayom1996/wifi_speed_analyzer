import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wifi_speed_analyzer/theme/color_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Speedometer extends StatelessWidget {
  Speedometer({
    @required this.speed,
    @required this.speedRecord,
    this.size = 300
  });

  final double speed;
  final double speedRecord;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SpeedometerPainter(
        speed: speed,
        speedRecord: speedRecord
      ),
      size: Size(size, size)
    );
  }
}

class SpeedometerPainter extends CustomPainter {
  SpeedometerPainter({
    this.speed,
    this.speedRecord
  });

  final double speed;
  final double speedRecord;

  Size size;
  Canvas canvas;
  Offset center;
  Paint paintObject;

  @override
  void paint(Canvas canvas, Size size) {
    _init(canvas, size);

    // _drawOuterCircle();
    // _drawInnerCircle();
    // _drawMarkers();
    _drawSpeedIndicators(size);
    // _drawNeedle(
    //   0.15 + (speedRecord / 100),
    //   Colors.white54,
    //   size.width / 120
    // );
    _drawNeedle(
      0.15 + (speed / 150),
      mainColor,
      6.sp
    );
    _drawNeedleHolder();
    _drawSpeed();
  }

  void _drawSpeedIndicators(Size size) {
    for (double percentage = 0.15; percentage <= 0.85; percentage += 4 / 500) {
      _drawSpeedIndicator(percentage);
    }

    for (double percentage = 0.15; percentage < 0.15 + (speed / 150); percentage += 4 / 500) {
      _drawSpeedIndicator(percentage, true);
    }
  }

  void _drawSpeedIndicator(double relativeRotation, [bool highlight = false]) {
    paintObject.shader = null;
    paintObject.strokeWidth = 2;
    // paintObject.style = PaintingStyle.stroke;
    paintObject.style = PaintingStyle.fill;
    paintObject.color = Color(0xff5B5B5B);

    if (highlight) {
      // paintObject.color = Color.lerp(
      //   Colors.yellow, Colors.red, (relativeRotation - 0.15) / 0.7
      // );
      paintObject.color = mainColor;
      paintObject.style = PaintingStyle.fill;
    }

    Path markerPath = Path()
      ..addRect(
        Rect.fromLTRB(
          center.dx - size.width / 40,
          size.width - (size.width / 15),
          center.dx,
          size.width - (size.width / 150)
        )
      );

    _drawRotated(relativeRotation, () {
      canvas.drawPath(markerPath, paintObject);
    });
  }

  void _init(Canvas canvas, Size size) {
    this.canvas = canvas;
    this.size = size;
    center = size.center(Offset.zero);
    paintObject = Paint();
  }

  void _drawNeedleHolder() {
    RadialGradient gradient = RadialGradient(
      colors: [Color(0xff63BA9C), Color(0xff63BA9C), Color(0xff63BA9C), Colors.black],
      radius: 1.2,
      stops: [0.0, 0.7, 0.9, 1.0]
    );

    paintObject
      ..color = mainColor
      ..shader = gradient.createShader(
        Rect.fromCenter(
          center: center,
          width: 30.w,
          height: 30.h
        )
      );

    canvas.drawCircle(
      size.center(Offset.zero),
      size.width / 15,
      paintObject
    );
  }

  void _drawRotated(double angle, Function drawFunction) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle * pi * 2);
    canvas.translate(-center.dx, -center.dy);
    drawFunction();
    canvas.restore();
  }


  void _drawMarker(bool isBigMarker) {
    paintObject
      ..color = Colors.red
      ..shader = null;

    Path markerPath = Path()
      ..addRect(
        Rect.fromLTRB(
          center.dx - size.width / (isBigMarker ? 200 : 300),
          center.dy + (size.width / 2.2),
          center.dx + size.width / (isBigMarker ? 200 : 300),
          center.dy + (size.width / (isBigMarker ? 2.5 : 2.35)),
        )
      );

    canvas.drawPath(markerPath, paintObject);
  }

  void _drawSpeed() {
    TextSpan spanSpeed = new TextSpan(
      style: GoogleFonts.openSans(
        textStyle: TextStyle(
            fontSize: 30.sp,
            fontWeight: FontWeight.w600
        ),
      ),
      text: '${speed.toStringAsFixed(2)}'
    );

    TextSpan spanMbps = new TextSpan(
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: mainColor
          ),
        ),
        text: 'Mbps'
    );

    TextPainter speedPainter = TextPainter(
      text: spanSpeed,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    );

    TextPainter mbpsPainter = TextPainter(
        text: spanMbps,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center
    );

    speedPainter.layout();
    mbpsPainter.layout();

    final textSpeedCenter = Offset(
      center.dx,
      center.dy
    );

    final textMbpsCenter = Offset(
        center.dx,
        center.dy
    );

    final textTopLeft = Offset(
        textSpeedCenter.dx - (speedPainter.width / 2),
        textSpeedCenter.dy + 80
    );

    final textTopLeft1 = Offset(
        textMbpsCenter.dx - (mbpsPainter.width / 2),
        textMbpsCenter.dy + 120
    );

    speedPainter.paint(canvas, textTopLeft);
    mbpsPainter.paint(canvas, textTopLeft1);
    // textPainter.paint(canvas, textTopLeft);
  }

  void _drawNeedle(double rotation, Color color, double width) {
    paintObject
      ..style = PaintingStyle.fill
      ..color = color;

    Path needlePath = Path()
      ..moveTo(center.dx - width, center.dy)
      ..lineTo(center.dx + width, center.dy)
      ..lineTo(center.dx, center.dy + size.width / 3.5)
      ..moveTo(center.dx - width, center.dy);

    _drawRotated(rotation, () {
      canvas.drawPath(needlePath, paintObject);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}