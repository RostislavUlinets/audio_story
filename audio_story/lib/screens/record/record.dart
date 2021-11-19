import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/models/audio_records.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widget/player.dart';
import 'widget/timer.dart';

class Records extends StatefulWidget {
  const Records({Key? key}) : super(key: key);

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  final recorder = AudioRecord();

  @override
  void initState() {
    super.initState();
    recorder.init();
  }

  @override
  void dispose() {
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Image(
                            image: AssetImage("assets/Upload.png"),
                          ),
                          Image(
                            image: AssetImage("assets/PaperDownload1.png"),
                          ),
                          Image(
                            image: AssetImage("assets/Delete.png"),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text("Сохранить"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
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
                    AudioTimer(),
                    buildStart(),
                    IconButton(
                      onPressed: () {
                      },
                      icon: Icon(Icons.arrow_drop_up),
                    ),
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

    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? 'STOP' : 'START';
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.white : Colors.black;

    return ElevatedButton.icon(
      onPressed: () async {
        final isRecording = await recorder.toggleRecording();
        setState(() {});
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
