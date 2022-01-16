import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/service/auth.dart';
import 'package:audio_story/widgets/audio_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

DatabaseService dataBase =
    DatabaseService(FirebaseAuth.instance.currentUser!.uid);

class CustomList extends StatelessWidget {
  const CustomList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    const Text(
                      "Аудиозаписи",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black54,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        final navigationProvider =
                            context.read<NavigationProvider>();
                        navigationProvider.changeScreen(3);
                      },
                      child: const Text(
                        "Открыть все",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
              AuthService.isAnonymous()
                  ? Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            'Как только ты запишешь\nаудио, она появится здесь.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Image(
                          image: AppIcons.arrowDown,
                        ),
                      ],
                    )
                  : FutureBuilder(
                      future: dataBase.audioListDB(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const CircularProgressIndicator(
                              color: AppColors.purpule,
                              strokeWidth: 1.5,
                            );
                          default:
                            return Expanded(
                              child: AudioScreenList(
                                audio: snapshot.data,
                              ),
                            );
                        }
                      },
                    ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 10,
              blurRadius: 10,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: 350,
      ),
    );
  }
}
