import 'package:flutter/material.dart';

class MusicVisualizer extends StatelessWidget {
  MusicVisualizer({Key? key}) : super(key: key);

  List<Color> colors = [
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.redAccent,
    Colors.yellowAccent
  ];
  List<int> duration = [900, 700, 600, 800, 500];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(
        10,
        (index) => VisualizerComponent(
          duration: duration[index % 5],
          color: colors[index % 4],
        ),
      ),
    );
  }
}

class VisualizerComponent extends StatefulWidget {
  const VisualizerComponent(
      {Key? key, required this.duration, required this.color})
      : super(key: key);
  final int duration;
  final Color color;
  @override
  _VisualizerComponentState createState() => _VisualizerComponentState();
}

class _VisualizerComponentState extends State<VisualizerComponent>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: widget.duration), vsync: this);
    final curvedAnimation =
        CurvedAnimation(parent: animationController!, curve: Curves.decelerate);

    animation = Tween<double>(begin: 0, end: 60).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    animationController!.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(5),
      ),
      height: animation!.value,
    );
  }
}
