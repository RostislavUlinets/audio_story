import 'dart:convert';

import 'dart:io';

import 'package:audio_story/models/audio.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/screens/category/category.dart';

import 'package:audio_story/screens/category/create_category/add_audio.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';

import 'package:audio_story/widgets/audio_list.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateCategory extends StatefulWidget {
  static const routeName = '/createCategory';

  const CreateCategory({Key? key}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  File? image;
  late String img64;
  final _name = TextEditingController(text: "Название");
  final _info = TextEditingController(text: "");
  List<AudioModel>? soundList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          const MyCustomPaint(
            color: AppColors.green,
            size: 0.85,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
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
                            Navigator.pushNamed(context, MainScreen.routeName);
                          },
                          icon: Image(
                            image: AppIcons.arrowLeftInCircle,
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "Создание",
                      style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        if (image == null || soundList == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Пожалуйста, заполните все поля'),
                            ),
                          );
                        } else {
                          final db = DatabaseService(
                              FirebaseAuth.instance.currentUser!.uid);
                          db
                              .createPlayList(
                            img64,
                            _name.text,
                            _info.text,
                            soundList,
                          )
                              .whenComplete(() {
                            Navigator.pushNamed(context, Category.routeName);
                          });
                        }
                      },
                      child: const Text(
                        "Готово",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: TextField(
                    maxLength: 14,
                    readOnly: false,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: _name,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
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
                          : null,
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text("Введите описание..."),
                ),
                TextField(
                  maxLength: 120,
                  controller: _info,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    helperText: "Готово",
                    helperStyle: TextStyle(fontSize: 14, color: Colors.black),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.black),
                    ),
                  ),
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 35.0,
                    ),
                    child: soundList == null
                        ? TextButton(
                            onPressed: () async {
                              soundList = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AddAudio(),
                                ),
                              ).whenComplete(
                                () => setState(() {}),
                              );
                            },
                            child: const Text(
                              "Добавить аудиофайл",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: AppColors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 250,
                            width: double.infinity - 50,
                            child: AudioScreenList(
                              audio: soundList!,
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //FilePicker + base64 Convertor
  // Future getSoundsList(var SoundList) async {
  //   log(SoundList.toString());
  // }

  Future selectFile() async {
    final result = await ImagePicker().pickImage(
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
