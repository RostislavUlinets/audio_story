import 'package:flutter/material.dart';

class OutButton extends StatefulWidget {
  const OutButton({Key? key}) : super(key: key);

  @override
  _OutButtonState createState() => _OutButtonState();
}

class _OutButtonState extends State<OutButton> {
  Widget _localWidget = const SizedBox(
    height: 10,
    width: 10,
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _localWidget = const Image(
            image: AssetImage("assets/TickSquare.png"),
          );
        });
      },
      child: _localWidget,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(
            side: BorderSide(
          width: 2,
          color: Colors.black54,
        )),
        padding: const EdgeInsets.all(6),
        primary: Colors.white,
        onPrimary: Colors.black, // <-- Splash color
      ),
    );
  }
}