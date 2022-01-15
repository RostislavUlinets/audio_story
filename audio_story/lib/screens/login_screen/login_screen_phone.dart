import 'package:audio_story/resources/app_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:audio_story/service/auth.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:flutter/material.dart';

import 'widget/anonim.dart';

const AuthService _auth = AuthService.instance;

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  LoginScreen({Key? key}) : super(key: key);

  final _phoneController = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
      mask: '+## (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const MyCustomPaint(
            color: AppColors.purpule,
            size: 0.85,
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
                        "Введите номер телефона",
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
                            inputFormatters: [maskFormatter],
                            controller: _phoneController,
                            decoration: InputDecoration(
                              labelText: "+38 (0)",
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
                        final phone = _phoneController.text.trim();
                        _auth.loginUser(phone, context);
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
                    const Anonim(),
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
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Регистрация привяжет твои сказки\nк облаку, после чего они всегда\nбудут с тобой",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.black),
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
