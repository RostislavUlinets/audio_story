import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:flutter/material.dart';

import '../../widgets/side_menu.dart';
import '../../widgets/bottomnavbar.dart';
import 'widget/custom_list.dart';

class MainScreen extends StatelessWidget {

  static const routeName = '/';
  
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(0),
      drawer: const ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
        child: SideMenu(),
      ),
      body: Builder(
        builder: (ctx) => Stack(
          children: [
            const MyCustomPaint(
              color: CColors.purpule,
              size: 0.85,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Builder(
                        builder: (ctx) => IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 36,
                          ),
                          onPressed: () {
                            Scaffold.of(ctx).openDrawer();
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: const [
                        Text(
                          "Подборки",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        Spacer(),
                        Text(
                          "Открыть все",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "Здесь будет твой набор сказок",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xD971A59F),
                              border: Border.all(
                                color: const Color(0xD971A59F),
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 10,
                                  blurRadius: 10,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            height: 200,
                          ),
                          flex: 1,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  "Тут",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xD9F1B488),
                                  border: Border.all(
                                    color: const Color(0xD9F1B488),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 10,
                                      blurRadius: 10,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                height: 94,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  "И тут",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xD9678BD2),
                                  border: Border.all(
                                    color: const Color(0xD9678BD2),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 10,
                                      blurRadius: 10,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                height: 94,
                              ),
                            ],
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const CustomList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
