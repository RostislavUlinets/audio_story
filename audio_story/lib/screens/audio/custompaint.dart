import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CustomP extends StatelessWidget {
  const CustomP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
          400,
          (400 * 0.6714975845410628)
              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
      painter: RPSCustomPainter(),
    );
  }
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.2472657, size.height * 0.5041763);
    path_0.cubicTo(
        size.width * 0.1037923,
        size.height * 0.9910180,
        size.width * 1.258843,
        size.height * 1.132709,
        size.width * 1.428442,
        size.height * 0.2868719);
    path_0.cubicTo(
        size.width * 1.640442,
        size.height * -0.7704281,
        size.width * -0.7055145,
        size.height * -0.1313155,
        size.width * -0.2472657,
        size.height * 0.5041763);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff5E77CE).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
