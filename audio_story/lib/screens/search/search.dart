
import 'package:audio_story/models/audio.dart';
import 'package:audio_story/provider/current_audio_provider.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/screens/audio_card/audo_info.dart';
import 'package:audio_story/screens/search/search_field.dart';
import 'package:audio_story/service/auth.dart';
import 'package:audio_story/widgets/anon_message.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);

  List<AudioModel> audio = [];
  List<AudioModel> allAudio = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    dataBase.audioListDB().then((value) {
      audio = value;
      allAudio = audio;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = context.watch<CurrentAudio>();
    return AuthService.isAnonymous()
        ? const AnonMessage()
        : Scaffold(
            extendBody: true,
            body: Stack(
              children: [
                const MyCustomPaint(
                  color: AppColors.blue,
                  size: 0.7,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 60.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Column(
                            children: const [
                              Text(
                                "Поиск",
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Найди потеряшку",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                              size: 36,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: buildSearch(),
                      ),
                      Expanded(
                        // child: AudioScreenList(audio: allAudio),
                        child: ListView.builder(
                          itemCount: audio.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Container(
                                child: ListTile(
                                  title: Text(
                                    audio[index].name,
                                    style: const TextStyle(
                                      color: Color(0xFF3A3A55),
                                    ),
                                  ),
                                  subtitle: const Text(
                                    "30 минут",
                                    style: TextStyle(color: Color(0x803A3A55)),
                                  ),
                                  leading: IconButton(
                                    padding: EdgeInsets.zero,
                                    iconSize: 64,
                                    icon: audioProvider.audioName ==
                                            audio[index].name
                                        ? Image(
                                            image: AppIcons.pause,
                                            color: AppColors.purpule,
                                          )
                                        : Image(
                                            image: AppIcons.play,
                                          ),
                                    onPressed: () {
                                      Scaffold.of(context).showBottomSheet(
                                        (context) => PlayerOnProgress(
                                          soundsList: audio,
                                          index: index,
                                          repeat: false,
                                          cycle: false,
                                          audioProvider: audioProvider,
                                        ),
                                      );
                                    },
                                  ),
                                  trailing: PopupMenuButton(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.more_horiz,
                                      size: 32,
                                      color: Colors.black54,
                                    ),
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: const Text("Переименовать"),
                                        onTap: () {},
                                        value: 1,
                                      ),
                                      PopupMenuItem(
                                        child: const Text("Подробнее об аудиозаписи"),
                                        onTap: () {
                                          Future.delayed(
                                            const Duration(seconds: 0),
                                            () => Navigator.pushNamed(
                                              context,
                                              AudioInfo.routeName,
                                              arguments: audio[index],
                                            ),
                                          );
                                        },
                                        value: 2,
                                      ),
                                      PopupMenuItem(
                                        child: const Text("Удалить"),
                                        onTap: () {
                                          dataBase.deleteAudio(audio[index].id);
                                          setState(() {
                                            audio[index];
                                          });
                                        },

                                        value: 3,
                                      ),
                                      PopupMenuItem(
                                        child: const Text("Поделиться"),
                                        onTap: () async {
                                        },
                                        value: 4,
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(75),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Поиск',
        onChanged: searchBook,
      );

  void searchBook(String query) {
    final audioList = allAudio.where((element) {
      final nameToLower = element.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameToLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      audio = audioList;
    });
  }
}
