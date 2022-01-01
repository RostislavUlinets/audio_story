import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              color: CColors.purpule,
              strokeWidth: 1.5,
            );
          default:
            {
              List<Image> playListImage = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: playListImage[0].image,
                            fit: BoxFit.fill,
                          ),
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
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: playListImage[1].image,
                                fit: BoxFit.fill,
                              ),
                              color: const Color(0xD9F1B488),
                              border: Border.all(
                                color: const Color(0xD9F1B488),
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
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: playListImage[2].image,
                                fit: BoxFit.fill,
                              ),
                              color: const Color(0xD9678BD2),
                              border: Border.all(
                                color: const Color(0xD9678BD2),
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
