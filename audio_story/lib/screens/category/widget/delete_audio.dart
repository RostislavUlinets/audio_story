import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/screens/category/open_category/card_info.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class DeleteAlert extends StatelessWidget {
  final index;

  const DeleteAlert({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text("Подтверждаете удаление?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.red)),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Ваш файл перенесется в папку “Недавно удаленные”.\nЧерез 15 дней он исчезнет.",
                  style: TextStyle(
                      fontSize: 14, color: AppColors.black.withOpacity(0.5)),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Row(
                  children: [
                    _continueButton(context, index),
                    const Spacer(),
                    _cancelButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
        height: 180,
        width: 350,
      ),
    );
  }

  Widget _cancelButton(BuildContext context) {
    return TextButton(
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
  }

  Widget _continueButton(BuildContext context, int index) {
    return TextButton(
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
        backgroundColor: MaterialStateProperty.all(AppColors.purpule),
      ),
      onPressed: () {
        dataBase
            .deletePlayList(index)
            .then(
              (value) => Navigator.pop(context),
            )
            .then(
              (value) => Navigator.pushNamed(context, MainScreen.routeName),
            );
      },
    );
  }
}

class DeleteAudio {
  static void deletePlayList(BuildContext context, int index) {
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
        backgroundColor: MaterialStateProperty.all(AppColors.purpule),
      ),
      onPressed: () {
        dataBase.deletePlayList(index).then(
              (value) => Navigator.pop(context),
            );
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
                child: Text("Подтверждаете удаление?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.red)),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Ваш файл перенесется в папку “Недавно удаленные”.\nЧерез 15 дней он исчезнет.",
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
        width: 350,
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
}
