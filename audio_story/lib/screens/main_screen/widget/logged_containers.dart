import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

DatabaseService dataBase =
    DatabaseService(FirebaseAuth.instance.currentUser!.uid);

class LoggedContainers extends StatelessWidget {
  const LoggedContainers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dataBase.getPlayListImages(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator(
              color: AppColors.purpule,
              strokeWidth: 1.5,
            );
          default:
            {
              List<Map<String, dynamic>> playListImage = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          final navigationProvider =
                              context.read<NavigationProvider>();
                          navigationProvider.changeScreen(1);
                        },
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  playListImage[0]['name'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    height: 1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                 Text(
                                  "${playListImage[0]['length']} ?????????? \n1:30 ????????",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                              image: playListImage[0]['image'].image,
                              fit: BoxFit.fill,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.8),
                                BlendMode.dstATop,
                              ),
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
                      ),
                      flex: 1,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              final navigationProvider =
                                  context.read<NavigationProvider>();
                              navigationProvider.changeScreen(1);
                            },
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      playListImage[1]['name'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        height: 1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "${playListImage[1]['length']} ??????????\n1:30 ????????",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                  image: playListImage[1]['image'].image,
                                  fit: BoxFit.fill,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.8),
                                    BlendMode.dstATop,
                                  ),
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
                              height: 94,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              final navigationProvider =
                                  context.read<NavigationProvider>();
                              navigationProvider.changeScreen(1);
                            },
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      playListImage[2]['name'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        height: 1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "${playListImage[2]['length']} ?????????? \n1:30 ????????",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                  image: playListImage[2]['image'].image,
                                  fit: BoxFit.fill,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.8),
                                    BlendMode.dstATop,
                                  ),
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
                              height: 94,
                            ),
                          ),
                        ],
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              );
            }
        }
      },
    );
  }
}
