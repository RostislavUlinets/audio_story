import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/bloc/delete/delete_bloc.dart';
import 'package:audio_story/bloc/delete/delete_state.dart';
import 'package:audio_story/screens/deleted/deleted.dart';
import 'package:audio_story/screens/deleted/select.dart';
import 'package:audio_story/service/auth.dart';
import 'package:audio_story/widgets/anon_message.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({Key? key}) : super(key: key);

  static const routeName = '/deleted';

  @override
  _DeleteScreenState createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  @override
  Widget build(BuildContext context) {
    return AuthService.isAnonymous()
        ? const AnonMessage()
        : BlocProvider<MyBloc>(
            create: (_) => MyBloc(),
            child: BlocBuilder<MyBloc, MyState>(
              builder: (_, state) =>
                  state is StateA ? const DeelteMode() : const SelectMode(),
            ),
          );
  }
}
