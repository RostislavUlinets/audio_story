import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/models/audio.dart';
import 'package:audio_story/screens/audio_card/add_to_category.dart';
import 'package:audio_story/screens/audio_card/widget/player.dart';
import 'package:audio_story/service/local_storage.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:flutter/material.dart';

class AudioInfo extends StatelessWidget {
  static const routeName = '/audioInfo';

  final String name, url, id;

  const AudioInfo(
      {Key? key, required this.name, required this.url, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(2),
      body: Stack(
        children: [
          const MyCustomPaint(
            color: CColors.purpule,
            size: 0.7,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Image.asset('assets/Arrow - Left Circle.png'),
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
                                    Duration(seconds: 0),
                                    () => Navigator.pushNamed(
                                      context,
                                      CustomCategory.routeName,
                                      arguments: [
                                        AudioModel(id: id, name: '', url: '')
                                      ],
                                    ),
                                  );
                                },
                                value: 1,
                              ),
                              const PopupMenuItem(
                                child: Text("Редактировать название"),
                                value: 2,
                              ),
                              PopupMenuItem(
                                child: const Text("Поделиться"),
                                onTap: () {},
                                value: 3,
                              ),
                              PopupMenuItem(
                                child: const Text("Скачать"),
                                onTap: () async {
                                  LocalStorage storage = LocalStorage();
                                  final message = await storage.downloadFile(
                                    url,
                                    name,
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
                                onTap: () {},
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
                      child: Text(
                        name,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    PlayerOnProgress(
                      name: name,
                      url: url,
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
      ),
    );
  }
}
