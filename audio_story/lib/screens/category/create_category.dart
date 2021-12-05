import 'dart:developer';
import 'dart:io';
import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

File? file, image = null;

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;

    final path = result.files.single.path;

    file = File(path!);

    final bytes = await File(path).readAsBytes();
    final db =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);
    db.setBase64(bytes.toString());
    file!.writeAsBytesSync(bytes);
    image = file;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var _infoController = TextEditingController();
    return Scaffold(
      bottomNavigationBar: const CustomNavigationBar(1),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            MyCustomPaint(color: CColors.green),
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
                              Navigator.pop(context);
                            },
                            icon: Image.asset('assets/ArrowBack.png'),
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
                      const Text(
                        "Готово",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Название",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectFile();
                    },
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: image != null
                            ? DecorationImage(
                                image: FileImage(image!),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: AssetImage('assets/story.jpg'),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text("Введите описание..."),
                  ),
                  TextField(
                    controller: _infoController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: CColors.black),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70.0),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Добавить аудиофайл",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: CColors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
