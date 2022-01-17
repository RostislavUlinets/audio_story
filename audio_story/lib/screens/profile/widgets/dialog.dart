import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/screens/login_screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context) {
  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text(
      "Нет",
      style: TextStyle(color: AppColors.purpule),
    ),
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(color: AppColors.purpule),
        ),
      ),
    ),
    onPressed: () => Navigator.pop(context),
  );
  Widget continueButton = TextButton(
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        "Удалить",
        style: TextStyle(color: Colors.white),
      ),
    ),
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(AppColors.red),
    ),
    onPressed: () async {
      // FirebaseAuth.instance.currentUser!.delete();
      dataBase.deleteUser();
      FirebaseAuth.instance.signOut();
      Navigator.pop(context);
      Navigator.of(context, rootNavigator: true)
          .pushReplacementNamed(WelcomeScreen.routeName);
    },
  );

  // set up the AlertDialog
  Widget alert = AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    content: SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text("Точно удалить аккаунт?",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Все аудиофайлы исчезнут и восстановить аккаунт будет невозможно",
                style: TextStyle(
                    fontSize: 14, color: AppColors.black.withOpacity(0.5)),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Row(
                children: [
                  continueButton,
                  const Spacer(),
                  cancelButton,
                ],
              ),
            ),
          ],
        ),
      ),
      height: 180,
      width: 300,
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
