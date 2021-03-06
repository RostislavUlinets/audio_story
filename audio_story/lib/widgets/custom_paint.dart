import 'package:flutter/material.dart';

class MyCustomPaint extends StatelessWidget {

  final Color color;
  final double size;

  const MyCustomPaint({Key? key, required this.color,required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return             CustomPaint(
              size: Size(
                400,
                (400 * size).toDouble(),
              ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: RPSCustomPainter(color),
            );
  }
}

class RPSCustomPainter extends CustomPainter {
  RPSCustomPainter(this.color);

  final Color color;

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
    paint0Fill.color = color;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}