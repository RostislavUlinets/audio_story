import 'dart:convert';

import 'package:audio_story/models/sounds.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/screens/category/category.dart';
import 'package:audio_story/widgets/audio_content.dart';
import 'package:audio_story/widgets/audio_list.dart';
import 'package:audio_story/screens/category/open_category/editing_playlist.dart';
import 'package:audio_story/screens/category/widget/description.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'list_select_mode.dart';
import '../widget/delete_audio.dart';

final user = FirebaseAuth.instance.currentUser;
DatabaseService dataBase =
    DatabaseService(FirebaseAuth.instance.currentUser!.uid);
final CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');

late SoundModel audioPropeperty;

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

class CardInfo extends StatefulWidget {
  static const routeName = '/cardInfo';

  final int index;

  const CardInfo({Key? key, required this.index}) : super(key: key);

  @override
  State<CardInfo> createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  late final int index;

  @override
  void initState() {
    index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dataBase.getSaveList(index).then(
            (value) => audioPropeperty = value,
          ),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
            return Stack(
              children: [
                const MyCustomPaint(
                  color: AppColors.green,
                  size: 0.85,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 60.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Image(
                                    image: AppIcons.arrowLeftInCircle,
                                  ),
                                ),
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
                                color: Colors.white,
                              ),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: const Text("??????????????????????????"),
                                  onTap: () {
                                    Future.delayed(
                                      const Duration(seconds: 0),
                                      () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditingPlayList(
                                            index: index,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  value: 1,
                                ),
                                PopupMenuItem(
                                  child: const Text("?????????????? ??????????????????"),
                                  onTap: () {
                                    Future.delayed(
                                      const Duration(seconds: 0),
                                      () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SelectModeList(
                                            audioPropeperty: audioPropeperty,
                                            index: index,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  value: 2,
                                ),
                                PopupMenuItem(
                                  child: const Text("?????????????? ????????????????"),
                                  onTap: () {
                                    Future.delayed(
                                      const Duration(seconds: 0),
                                      () => showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DeleteAlert(
                                            index: index,
                                          );
                                        },
                                      ).then(
                                        (value) =>
                                            Navigator.pushReplacementNamed(
                                                context, Category.routeName),
                                      ),
                                    );
                                  },
                                  value: 3,
                                ),
                                const PopupMenuItem(
                                  child: Text("????????????????????"),
                                  value: 4,
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            audioPropeperty.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Text(
                                      "${audioPropeperty.sounds.length} ??????????\n1:30 ????????",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                    width: 70,
                                  ),
                                  const AudioButton(),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: audioPropeperty.image.image,
                                fit: BoxFit.cover,
                              ),
                              color: Colors.black,
                            ),
                            height: 210,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: DescriptionTextWidget(
                            text: audioPropeperty.info,
                          ),
                        ),
                        Expanded(
                          child: AudioScreenList(
                            audio: snapshot.data.sounds,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}
