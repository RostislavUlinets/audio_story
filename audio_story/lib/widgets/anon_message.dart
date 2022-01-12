import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:flutter/material.dart';

import 'bottomnavbar.dart';

class AnonMessage extends StatelessWidget {
  const AnonMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true,
      body: Center(
        child: Text(
          'Данная функция станет\nдоступной после авторизации',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
