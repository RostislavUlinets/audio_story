import 'package:audio_story/models/audio.dart';
import 'package:audio_story/provider/current_audio_provider.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/screens/search/search_field.dart';
import 'package:audio_story/service/auth.dart';
import 'package:audio_story/widgets/anon_message.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/player.dart';
import 'package:audio_story/widgets/side_menu.dart';
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
                          const Text(
                            "Поиск",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
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
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: buildSearch(),
                      ),
                      Expanded(
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
                                  leading: Builder(builder: (context) {
                                    return IconButton(
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
                                    );
                                  }),
                                  trailing: const Icon(Icons.more_horiz),
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
        hintText: 'Title or Author Name',
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
