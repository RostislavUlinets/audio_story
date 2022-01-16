import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/screens/deleted/select.dart';
import 'package:audio_story/screens/deleted/widget/custom_list.dart';
import 'package:audio_story/service/auth.dart';
import 'package:audio_story/widgets/anon_message.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final DatabaseService dataBase =
    DatabaseService(FirebaseAuth.instance.currentUser!.uid);

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({Key? key}) : super(key: key);

  static const routeName = '/deleted';

  @override
  _DeleteScreenState createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  bool selectMode = false;

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
                    horizontal: 10.0, vertical: 60.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 100),
                      child: Row(
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
                            "Недавно\nудаленные",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
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
                              color: Colors.white,
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: const Text("Выбрать несколько"),
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(SelectMode.routeName);
                                },
                                value: 1,
                              ),
                              PopupMenuItem(
                                child: const Text("Удалить все"),
                                onTap: () {},
                                value: 2,
                              ),
                              PopupMenuItem(
                                child: const Text("Восстановить все"),
                                onTap: () {},
                                value: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder(
                      future: dataBase.getDeletedAudio(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
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
                            return Expanded(
                                child: ListWidget(
                              audio: snapshot.data,
                            ));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
