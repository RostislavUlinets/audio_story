import 'package:audio_story/screens/audio/custompaint.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(3),
      body: Stack(
        children: [
          const CustomP(),
        ],
      ),
    );
  }
}
