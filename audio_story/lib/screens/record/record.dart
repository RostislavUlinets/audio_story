import 'dart:async';

import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/screens/record/player.dart';
import 'package:audio_story/service/audio_records.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widget/player.dart';
import 'widget/test.dart';
import 'widget/timer.dart';

class Records extends StatefulWidget {

  static const routeName = '/record';

  const Records({Key? key}) : super(key: key);

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  final recorder = AudioRecord();
  final player = SoundPlayer();

  @override
  void initState() {
    super.initState();
    recorder.init().then((value) => recorder.record());
    player.init();
  }

  @override
  void dispose() {
    player.dispose();
    recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: const SideMenu(),
      bottomNavigationBar: const CustomNavigationBar(2),
      body: Stack(
        children: [
          MyCustomPaint(color: CColors.purpule),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Builder(
                      builder: (ctx) => IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 36,
                        ),
                        onPressed: () {
                          Scaffold.of(ctx).openDrawer();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 385,
                height: 580,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text("Отменить"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Запись',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100.0),
                      child: Text(
                          '-------------------------------------------------------------------'),
                    ),
                    const AudioTimer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: buildStart(),
                    ),
                    /*
                    const Text(
                      "Аудиозапись 1",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 100),
                      child: Text(
                          "---------------------------------------------------------------"),
                    ),
                    
                    IconButton(
                      onPressed: () async {
                        await player.togglePlaying(whenFinished: () => setState(() {}));
                        setState(() {});
                      },
                      icon: Icon(Icons.arrow_drop_up,size: 64,),
                    ),*/
                    //IconButton(onPressed: (){}, icon: const Image(image: AssetImage("assets/PlayRec.png"),),iconSize: 92,)
                  ],
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildStart() {
    final isRecording = recorder.isRecording;

    final icon = Icons.stop;
    final text = 'STOP';
    final primary = Colors.red;
    final onPrimary = Colors.white;

    return ElevatedButton.icon(
      onPressed: () async {
        recorder.toggleRecording();
          NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);
        navigation.changeScreen('/player');
      },
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        primary: primary,
        onPrimary: onPrimary,
      ),
    );
  }
}
