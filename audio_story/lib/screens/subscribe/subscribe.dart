import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';

import 'package:flutter/material.dart';

class Subscribe extends StatelessWidget {
  const Subscribe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      bottomNavigationBar: const CustomNavigation(),
      body: Stack(
        children: [
          const MyCustomPaint(),
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
                          //Scaffold.of(context).openDrawer();
                          //TODO: "Fix";
                        },
                      ),
                      SizedBox(
                        width: 55,
                      ),
                      Text(
                        "Подписка",
                        style: TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Расширь возможности",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 30),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Text(
                            "Выбери подписку",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "300p",
                                      style: TextStyle(fontSize: 26),
                                    ),
                                    Text(
                                      "в месяц",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    OutButton(),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                height: 230,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "1800р",
                                      style: TextStyle(fontSize: 26),
                                    ),
                                    Text(
                                      "в год",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    OutButton(),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                height: 230,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25.0),
                                child: Row(
                                  children: [
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
                                    image: AssetImage("assets/Infinity.png"),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Неограниченая память",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage("assets/CloudUpload.png"),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Все файлы хранятся в облаке",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Image(
                                    image:
                                        AssetImage("assets/PaperDownload.png"),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Возможность скачивать без ограничений",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                child: const Text("Подписаться на месяц"),
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                  primary: Colors.deepOrange[200],
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
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
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  height: 560,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OutButton extends StatefulWidget {
  OutButton({Key? key}) : super(key: key);

  @override
  _OutButtonState createState() => _OutButtonState();
}

class _OutButtonState extends State<OutButton> {
  Widget _localWidget = SizedBox(
    height: 10,
    width: 10,
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _localWidget = Image(
            image: AssetImage("assets/TickSquare.png"),
          );
        });
      },
      child: _localWidget,
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(
            side: BorderSide(
          width: 2,
          color: Colors.black54,
        )),
        padding: EdgeInsets.all(6),
        primary: Colors.white,
        onPrimary: Colors.black, // <-- Splash color
      ),
    );
  }
}
