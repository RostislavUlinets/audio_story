import 'package:audio_story/Colors/colors.dart';
import 'package:flutter/material.dart';

class MusicVisualizer extends StatelessWidget {
  MusicVisualizer({Key? key}) : super(key: key);

  // List<Color> colors = [
  //   Colors.blueAccent,
  //   Colors.greenAccent,
  //   Colors.redAccent,
  //   Colors.yellowAccent
  // ];
  List<int> duration = [900, 700, 600, 800, 500];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(
        20,
        (index) => VisualizerComponent(
          duration: duration[index % 5],
          color: CColors.black,
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
  void dispose() {
    this.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: widget.duration), vsync: this);
    final curvedAnimation =
        CurvedAnimation(parent: animationController!, curve: Curves.decelerate);

    animation = Tween<double>(begin: 0, end: 60).animate(curvedAnimation)
      ..addListener(() {
        try {
          setState(() {});
        } catch (e) {}
      });
    animationController!.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(5),
      ),
      height: animation!.value,
    );
  }
}
