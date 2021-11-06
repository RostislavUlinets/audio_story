import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Records extends StatelessWidget {
  const Records({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CustomNavigationBar(2),
      body: Stack(
        children: [
          MyCustomPaint(color: CColors.purpule),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 36,
                    ),
                  ],
                ),
              ),
              Container(
                width: 385,
                height: 580,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image(
                            image: AssetImage("assets/Upload.png"),
                          ),
                          Image(
                            image: AssetImage("assets/PaperDownload1.png"),
                          ),
                          Image(
                            image: AssetImage("assets/Delete.png"),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text("Сохранить"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Аудиозапись 1",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: Text("---------------------------------------------------------------"),
                    ),
                    IconButton(onPressed: (){}, icon: Image(image: AssetImage("assets/PlayRec.png"),),iconSize: 92,)
                  ],
                ),
                
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
