import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showAlertDialog(BuildContext context) {

  NavigationController navigation =
      Provider.of<NavigationController>(context, listen: false);
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text(
      "Нет",
      style: TextStyle(color: CColors.purpule),
    ),
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(color: CColors.purpule),
        ),
      ),
    ),
    onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
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
      backgroundColor: MaterialStateProperty.all(CColors.red),
    ),
    onPressed: () async {
      FirebaseAuth.instance.currentUser!.delete();
      Navigator.of(context, rootNavigator: true).pop();
      navigation.changeScreen('');
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
                      color: CColors.black)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Все аудиофайлы исчезнут и восстановить аккаунт будет невозможно",
                style: TextStyle(
                    fontSize: 14, color: CColors.black.withOpacity(0.5)),
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
