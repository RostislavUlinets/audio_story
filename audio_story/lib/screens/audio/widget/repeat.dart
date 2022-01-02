import 'package:audio_story/Colors/colors.dart';
import 'package:flutter/material.dart';

class Repeat extends StatefulWidget {
  Repeat({Key? key}) : super(key: key);

  @override
  State<Repeat> createState() => _RepeatState();
}

class _RepeatState extends State<Repeat> {
  Color _color = Colors.white38;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.centerRight,
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: _color,
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                _color == Colors.white38
                    ? _color = Colors.white
                    : _color = Colors.white38;
                setState(() {});
              },
              child: Image(
                image: AssetImage("assets/fluent_arrow.png"),
                color: CColors.purpule,
              ),
            ),
          ),
        ),
        Container(
          height: 50,
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.white,
          ),
          child: Row(
            children: const [
              Image(
                image: AssetImage("assets/Play.png"),
                color: CColors.purpule,
              ),
              Text(
                "Запустить все",
                style: TextStyle(color: CColors.purpule),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
