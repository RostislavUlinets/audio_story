import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/widgets/audio_list.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddAudio extends StatelessWidget {
  const AddAudio({Key? key}) : super(key: key);

  void _sendDataBack(BuildContext context) {
    Navigator.pop(context, "123");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavigationBar(1),
      body: Stack(
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
                            _sendDataBack(context);
                          },
                          icon: Image.asset('assets/ArrowBack.png'),
                        ),
                      ),
                    ),
                    const Text(
                      "Выбрать",
                      style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        final db = DatabaseService(
                            FirebaseAuth.instance.currentUser!.uid);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Добавить",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: Container(
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45)),
                        labelText: 'Password',
                      ),
                    ),
                    height: 50,
                    width: double.infinity - 25,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(45),
                    ),
                  ),
                ),
                Container(
                  child: Expanded(
                    child: ListWidget(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
