import 'package:audio_story/models/audio.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/screens/audio_card/add_to_category.dart';
import 'package:audio_story/screens/audio_card/widget/player.dart';
import 'package:audio_story/service/local_storage.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:share/share.dart';

DatabaseService dataBase =
    DatabaseService(FirebaseAuth.instance.currentUser!.uid);

class AudioInfo extends StatefulWidget {
  static const routeName = '/audioInfo';

  final AudioModel audio;

  const AudioInfo({Key? key, required this.audio}) : super(key: key);

  @override
  State<AudioInfo> createState() => _AudioInfoState();
}

class _AudioInfoState extends State<AudioInfo> {
  AudioModel? audio;
  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    audio = widget.audio;
    _editingController.text = audio!.name;
  }

  bool _onlyRead = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MyCustomPaint(
          color: AppColors.purpule,
          size: 0.7,
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            final nav = context.read<NavigationProvider>();
                            if (nav.screenIndex != 0) {
                              nav.changeScreen(0);
                            } else {
                              nav.changeScreen(3);
                            }
                          },
                          icon: Image(
                            image: AppIcons.arrowDownInCircle,
                          ),
                        ),
                        PopupMenuButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          icon: const Icon(
                            Icons.more_horiz,
                            size: 32,
                            color: Colors.black54,
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: const Text("Добавить в подборку"),
                              onTap: () {
                                Future.delayed(
                                  const Duration(seconds: 0),
                                  () => Navigator.pushNamed(
                                    context,
                                    CustomCategory.routeName,
                                    arguments: [
                                      AudioModel(
                                          id: audio!.id, name: '', url: '')
                                    ],
                                  ),
                                );
                              },
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: const Text("Редактировать название"),
                              onTap: () {
                                setState(() {
                                  _onlyRead = !_onlyRead;
                                });
                              },
                              value: 2,
                            ),
                            PopupMenuItem(
                              child: const Text("Поделиться"),
                              onTap: () {
                                dataBase.downloadAllAudio([audio!]).then(
                                    (value) => Share.shareFiles(value));
                              },
                              value: 3,
                            ),
                            PopupMenuItem(
                              child: const Text("Скачать"),
                              onTap: () async {
                                LocalStorage storage = LocalStorage();
                                final message = await storage.downloadFile(
                                  audio!.url,
                                  audio!.name,
                                  '/sdcard/Download',
                                );
                                final snackBar = SnackBar(
                                  content: Text('Downloaded $message'),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              value: 4,
                            ),
                            PopupMenuItem(
                              child: const Text("Удалить"),
                              onTap: () {
                                dataBase.deleteAudio(audio!.id).whenComplete(
                                  () {
                                    final nav =
                                        context.read<NavigationProvider>();
                                    if (nav.screenIndex != 0) {
                                      nav.changeScreen(0);
                                    } else {
                                      nav.changeScreen(3);
                                    }
                                  },
                                );
                              },
                              value: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      child: Image.asset(
                        'assets/story.jpg',
                        fit: BoxFit.fill,
                      ),
                      height: 300,
                      width: 300,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _editingController,
                      readOnly: _onlyRead,
                      style: const TextStyle(
                        color: Color(0xFF3A3A55),
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      onEditingComplete: () {
                        dataBase.changeSoundName(
                          audio!.id,
                          _editingController.text,
                        );
                        setState(() {
                          audio = AudioModel(
                            id: audio!.id,
                            name: _editingController.text,
                            url: audio!.url,
                          );
                          _onlyRead = true;
                        });
                      },
                    ),
                  ),
                  PlayerOnProgress(
                    name: audio!.name,
                    url: audio!.url,
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}
