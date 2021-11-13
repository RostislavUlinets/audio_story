import 'dart:developer';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/models/auth.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final AuthService _auth = AuthService.instance;

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _phoneController = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(mask: '+## (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const MyCustomPaint(
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

class Anonim extends StatefulWidget {
  const Anonim({Key? key}) : super(key: key);

  @override
  _AnonimState createState() => _AnonimState();
}

class _AnonimState extends State<Anonim> {
  @override
  Widget build(BuildContext context) {
    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);
    return GestureDetector(
      onTap: () async {
        User? res = await _auth.signInAnon();
        if (res != null) {
          navigation.changeScreen('/');
        } else {
          log("Error with anonim auth");
        }
      },
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "Позже",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
