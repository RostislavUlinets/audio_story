import 'package:audio_story/blocs/repeat_cycle/repeat_bloc.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioButton extends StatelessWidget {
  const AudioButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonBloc, ButtonState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Stack(
          children: [
            if (state is ButtonCycleState) ...[
              Container(
                alignment: Alignment.centerRight,
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      context.read<ButtonBloc>().add(const ButtonStopEvent());
                    },
                    child: Image(
                      image: AppIcons.cycleArrow,
                      color: AppColors.purpule,
                    ),
                  ),
                ),
              ),
            ],
            if (state is ButtonInitialState || state is ButtonPlayAllState) ...[
              Container(
                alignment: Alignment.centerRight,
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white38,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      context.read<ButtonBloc>().add(const ButtonCycleEvent());
                    },
                    child: Image(
                      image: AppIcons.cycleArrow,
                      color: AppColors.purpule,
                    ),
                  ),
                ),
              ),
            ],
            GestureDetector(
              onTap: () {
                if (state is ButtonPlayAllState) {
                  context.read<ButtonBloc>().add(const ButtonStopEvent());
                } else {
                  context.read<ButtonBloc>().add(const ButtonPlayAllEvent());
                }
              },
              child: Container(
                height: 50,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    if (state is ButtonInitialState ||
                        state is ButtonCycleState) ...[
                      Image(
                        image: AppIcons.play,
                        height: 48,
                        width: 48,
                        color: AppColors.purpule,
                      )
                    ],
                    if (state is ButtonPlayAllState) ...[
                      Image(
                        image: AppIcons.pause,
                        height: 48,
                        width: 48,
                        color: AppColors.purpule,
                      ),
                    ],
                    const Text(
                      "Запустить все",
                      style: TextStyle(color: AppColors.purpule),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
