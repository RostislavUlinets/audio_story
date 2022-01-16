import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showAlertDialog(BuildContext context) {
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
    onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
  );
  Widget continueButton = TextButton(
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        "Да",
        style: TextStyle(color: Colors.white),
      ),
    ),
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(AppColors.purpule),
    ),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pushNamed(context, MainScreen.routeName);
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text("Подтверждаете удаление?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.red)),
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
