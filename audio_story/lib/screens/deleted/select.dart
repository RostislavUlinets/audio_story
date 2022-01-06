import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/bloc/delete/delete_bloc.dart';
import 'package:audio_story/bloc/delete/delete_event.dart';
import 'package:audio_story/models/audio.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/screens/deleted/delete_screen.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SelectMode extends StatefulWidget {
  static const String routeName = '/selectDeleted';

  const SelectMode({Key? key}) : super(key: key);

  @override
  _SelectModeState createState() => _SelectModeState();
}

class _SelectModeState extends State<SelectMode> {
  final DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);
  List<bool> select = [];
  List<String> playList = [];
  List<AudioModel> audio = [];

  @override
  void initState() {
    super.initState();
    dataBase.getDeletedAudio().then((value) {
      audio = value;
      select = List.filled(audio.length, false);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            onTap: (buttonIndex) {
              switch (buttonIndex) {
                case 0:
                  dataBase.recoverAudio(playList).then(
                        (value) => setState(() {}),
                      );
                  Navigator.pushNamed(context, MainScreen.routeName);
                  break;
                case 1:
                  dataBase.fullDeleteAudio(playList).then(
                        (value) => setState(() {}),
                      );
                  Navigator.pushNamed(context, MainScreen.routeName);
                  break;
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/Swap.png'),
                label: 'Восстановить все',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/Delete.png'),
                label: 'Удалить все',
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          const MyCustomPaint(
            color: CColors.blue,
            size: 0.7,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 60.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    "Недавно\nудаленные",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => context.read<MyBloc>().add(EventA()),
                        child: const Text(
                          'Отменить',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      itemCount: audio.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            child: ListTile(
                              title: Text(
                                audio[index].name,
                                style:
                                    const TextStyle(color: Color(0xFF3A3A55)),
                              ),
                              subtitle: const Text(
                                "30 минут",
                                style: TextStyle(color: Color(0x803A3A55)),
                              ),
                              leading: IconButton(
                                icon: const Image(
                                  image: AssetImage("assets/Play.png"),
                                ),
                                onPressed: () {
                                  Scaffold.of(context).showBottomSheet(
                                    (context) => PlayerOnProgress(
                                      soundsList: audio,
                                      index: index,
                                      repeat: false,
                                      cycle: false,
                                    ),
                                  );
                                },
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  if (select[index] == false) {
                                    select[index] = true;
                                    playList.add(audio[index].id);
                                    setState(() {});
                                  } else {
                                    select[index] = false;
                                    playList.removeWhere(
                                      (element) => element == audio[index].id,
                                    );
                                    setState(() {});
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 2, color: Colors.black)),
                                  child: Image(
                                    image: AssetImage('assets/TickSquare.png'),
                                    color: select[index]
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(75),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Container(

                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Column(
                //           children: [
                //             IconButton(
                //               onPressed: null,
                //               icon: Image.asset('assets/Swap.png'),
                //             ),
                //             const Text(
                //               'Восстановить все',
                //             ),
                //           ],
                //         ),
                //         Column(
                //           children: [
                //             IconButton(
                //               onPressed: null,
                //               icon: Image.asset('assets/Delete.png'),
                //             ),
                //             const Text(
                //               'Удалить все',
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
