import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/service/auth.dart';
import 'package:audio_story/widgets/anon_message.dart';
import 'package:audio_story/widgets/custom_paint.dart';

import 'package:flutter/material.dart';

import 'widget/select_button.dart';

class Subscribe extends StatelessWidget {
  static const routeName = '/subscribe';

  const Subscribe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthService.isAnonymous()
        ? const AnonMessage()
        : Stack(
            children: [
              const MyCustomPaint(
                color: AppColors.purpule,
                size: 0.85,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 36,
                            ),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                          const SizedBox(
                            width: 55,
                          ),
                          const Text(
                            "Подписка",
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      "Расширь возможности",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                "Выбери подписку",
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                            const SelectButton(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 25.0),
                                    child: Row(
                                      children: const [
                                        Text(
                                          "Что дает подписка:",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                        height: 16,
                                        width: 16,
                                        image: AppIcons.infinity,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        "Неограниченая память",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                        height: 16,
                                        width: 16,
                                        image: AppIcons.cloudUpload,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        "Все файлы хранятся в облаке",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                        height: 16,
                                        width: 16,
                                        image: AppIcons.paperDownload,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        "Возможность скачивать без ограничений",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    child: const Text("Подписаться на месяц"),
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      minimumSize:
                                          const Size(double.infinity, 50),
                                      primary: Colors.deepOrange[200],
                                      onPrimary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      height: 520,
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
