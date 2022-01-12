import 'dart:convert';
import 'dart:io';
import 'package:audio_story/models/sounds.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:audio_story/widgets/audio_list.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'widget/description.dart';

DatabaseService dataBase =
    DatabaseService(FirebaseAuth.instance.currentUser!.uid);

bool selectFlag = true;
late List<int> eraseList;

late SoundModel audioPropeperty;

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

class EditingPlayList extends StatefulWidget {
  final int index;

  EditingPlayList({Key? key, required this.index}) : super(key: key);

  @override
  _EditingPlayListState createState() => _EditingPlayListState();
}

class _EditingPlayListState extends State<EditingPlayList> {
  TextEditingController _nameField = TextEditingController();
  TextEditingController _infoField = TextEditingController();
  String img64 = '';
  File? image;

  @override
  void initState() {
    dataBase.getSaveList(widget.index).then((value) => setState(() {
          audioPropeperty = value;
          _nameField.text = audioPropeperty.name;
          _infoField.text = audioPropeperty.info;
        }));
    super.initState();
  }

  bool playAll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: const SideMenu(),
      bottomNavigationBar: const CustomNavigationBar(1),
      body: FutureBuilder(
        future: dataBase.getSaveList(widget.index).then(
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
                                        image: AppIcons.arrowLeftInCircle),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // dataBase.changePlayListData(_nameField.text, _infoField.text,_image);
                                  final db = DatabaseService(
                                      FirebaseAuth.instance.currentUser!.uid);
                                  // db.updatePlayList(img64, _Name.text, _Info.text);
                                  db.updatePlayList(
                                    img64,
                                    _nameField.text,
                                    _infoField.text,
                                    audioPropeperty.sounds,
                                    widget.index,
                                  );

                                  Navigator.pushNamed(
                                      context, MainScreen.routeName);
                                },
                                child: const Text(
                                  'Сохранить',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: TextField(
                              controller: _nameField,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => selectFile(),
                            child: Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: Image(
                                image: AppIcons.camera,
                                color: Colors.black,
                              ),
                              decoration: BoxDecoration(
                                image: image != null
                                    ? DecorationImage(
                                        image: FileImage(image!),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: audioPropeperty.image.image,
                                        fit: BoxFit.cover,
                                      ),
                                color: Colors.white.withOpacity(0.9),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: TextField(
                              controller: _infoField,
                              style: const TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          FutureBuilder(
                            future: dataBase
                                .getPlayListAudio(audioPropeperty.sounds),
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
                                      buttonState: false,
                                      cycleState: playAll,
                                    ),
                                  );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }

  Future selectFile() async {
    final result = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
        maxHeight: 300,
        maxWidth: 400);
    if (result == null) return;
    final bytes = await result.readAsBytes();
    img64 = base64Encode(bytes);

    setState(() {
      image = File(result.path);
    });
  }
}
