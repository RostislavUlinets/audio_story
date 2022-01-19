import 'dart:io';

import 'package:audio_story/blocs/record/record_bloc.dart';
import 'package:audio_story/blocs/record/record_state.dart';
import 'package:audio_story/screens/record/player.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'recrorder.dart';

Directory? path;
String? _downloadPath;

class Records extends StatefulWidget {
  static const routeName = '/record';

  const Records({Key? key}) : super(key: key);

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyBloc>(
      create: (_) => MyBloc(),
      child: BlocBuilder<MyBloc, MyState>(
        builder: (_, state) => state is StateA
            ? Recorder(
              )
            : Player(
              ),
      ),
    );
  }
}
