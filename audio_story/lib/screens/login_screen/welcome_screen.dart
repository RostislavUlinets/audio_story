import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomPaint(
            size: Size(
              400,
              (400 * 0.8913043478260869).toDouble(),
            ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            painter: RPSCustomPainter(),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("MemoryBox",
                      style:
                            TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold,color: Colors.white),),
                      Text("Твой голос всегда рядом!",
                      style:
                            TextStyle(fontSize: 14.0,color: Colors.white),)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Text(
                    "Привет!",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Text(
                    "Мы рады видеть тебя здесь.\nЭто приложение поможет записывать сказки и держать их в удобном месте не заполняя память на телефоне",
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  child: Text("Продолжить"),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    primary: Colors.deepOrange[200],
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
