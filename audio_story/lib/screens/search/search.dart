import 'package:audio_story/models/audio.dart';
import 'package:audio_story/screens/audio/custompaint.dart';
import 'package:audio_story/screens/search/search_field.dart';
import 'package:audio_story/widgets/audio_list.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/player.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'list.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<List<Audio>> audioListDB() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    ListResult result =
        await FirebaseStorage.instance.ref('Sounds/$uid/').listAll();
    List<Map<String, dynamic>> audio = [];
    List<Audio> audioFromModel = [];

    for (int i = 0; i < result.items.length; i++) {
      List<String> temp = result.items[i].name.split('_');
      temp.removeLast();

      audio.add({
        'name': temp.join('_'),
        'url': await result.items[i].getDownloadURL(),
      });

      audioFromModel.add(
        Audio(
          name: temp.join('_'),
          url: await result.items[i].getDownloadURL(),
        ),
      );
    }
    setState(() {});
    return audioFromModel;
  }

  late List<Audio> audio;
  late List<Audio> allAudio;
  String query = '';

  @override
  void initState() {
    super.initState();
    audioListDB().then((value) {
      audio = value;
      allAudio = audio;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(3),
      body: Stack(
        children: [
          const CustomP(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 60.0),
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
                      icon: Icon(
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
                SizedBox(
                  width: 350,
                  height: 410,
                  child: ListView.builder(
                    itemCount: audio.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          child: ListTile(
                            title: Text(
                              audio[index].name,
                              style: TextStyle(color: Color(0xFF3A3A55)),
                            ),
                            subtitle: Text(
                              "30 минут",
                              style: TextStyle(color: Color(0x803A3A55)),
                            ),
                            leading: Builder(
                              builder: (context) {
                                return IconButton(
                                  icon: Image(
                                    image: AssetImage("assets/Play.png"),
                                  ),
                                  onPressed: () {
                                    Scaffold.of(context).showBottomSheet(
                                      (context) => PlayerOnProgress(
                                        url: audio[index].url,
                                        name: audio[index].name,
                                      ),
                                    );
                                  },
                                );
                              }
                            ),
                            trailing: Icon(Icons.more_horiz),
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
      final url = element.url;
      final searchLower = query.toLowerCase();

      return nameToLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.audio = audioList;
    });
  }
}


