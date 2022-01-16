import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/widgets/audio_list.dart';
import 'package:audio_story/service/auth.dart';
import 'package:audio_story/widgets/anon_message.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widget/audio_content.dart';

DatabaseService dataBase =
    DatabaseService(FirebaseAuth.instance.currentUser!.uid);

class Audio extends StatelessWidget {
  static const routeName = '/audio';

  const Audio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthService.isAnonymous()
        ? const AnonMessage()
        : Stack(
            children: [
              const MyCustomPaint(
                color: AppColors.blue,
                size: 0.7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 60.0,
                ),
                child: FutureBuilder(
                  future: dataBase.audioListDB(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const SizedBox(
                          height: 250,
                          width: 250,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.purpule,
                              strokeWidth: 1.5,
                            ),
                          ),
                        );
                      default:
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                ),
                                const Text(
                                  "Аудиозаписи",
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            const Text(
                              "Все в одном месте",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 40,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${snapshot.data.length} аудио",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const AudioButton(),
                                ],
                              ),
                            ),
                            Expanded(
                              child: AudioScreenList(
                                audio: snapshot.data,
                              ),
                            ),
                          ],
                        );
                    }
                  },
                ),
              ),
            ],
          );
  }
}
