import 'package:flutter/material.dart';

ListView buildListView() {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (_, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              "Сказка \nо малыше Кокки",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            width: 90,
                          ),
                          Spacer(),
                          Container(
                            child: Text(
                              "n аудио\n1:30 часа",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                            width: 70,
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/story.jpg",
                        ),
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.8), BlendMode.dstATop),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.black,
                    ),
                    height: 210,
                    width: 180,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              "Сказка \nо малыше Кокки",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            width: 90,
                          ),
                          Spacer(),
                          Container(
                            child: Text(
                              "n аудио\n1:30 часа",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                            width: 70,
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/seconStory.jpg",
                        ),
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.8), BlendMode.dstATop),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.black,
                    ),
                    height: 210,
                    width: 180,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
