import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:flutter/material.dart';

class CodeSent extends StatelessWidget {
  

  CodeSent({Key? key}) : super(key: key);

  final _codeController = TextEditingController();

  void _sendDataBack(BuildContext context) {
    String textToSendBack = _codeController.text.trim();
    Navigator.pop(context, textToSendBack);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          MyCustomPaint(
            color: CColors.purpule,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 150),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      "Регистрация",
                      style: TextStyle(
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Введи код из смс, чтобы мы\nтебя запомнили",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: Material(
                        borderRadius: BorderRadius.circular(60.0),
                        elevation: 5,
                        shadowColor: Colors.grey,
                        child: Tooltip(
                          message: "SOMETHING",
                          child: TextField(
                            controller: _codeController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: const Text("Продолжить"),
                      onPressed: () {
                        _sendDataBack(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        primary: Colors.deepOrange[200],
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Регистрация привяжет твои сказки\nк облаку, после чего они всегда\nбудут с тобой",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: CColors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
