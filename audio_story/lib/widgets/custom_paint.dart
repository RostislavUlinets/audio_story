import 'package:flutter/material.dart';

class MyCustomPaint extends StatelessWidget {
  const MyCustomPaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return             CustomPaint(
              size: Size(
                400,
                (400 * 0.8913043478260869).toDouble(),
              ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: RPSCustomPainter(),
            );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.2, size.height * 0.5);
    path_0.cubicTo(size.width * 0.1, size.height * 1, size.width * 1.3,
        size.height * 1.1, size.width * 1.5, size.height * 0.3);
    path_0.cubicTo(size.width * 1.7, size.height * -0.7, size.width * -0.7,
        size.height * -0.1, size.width * -0.2, size.height * 0.5);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff8C84E2).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}