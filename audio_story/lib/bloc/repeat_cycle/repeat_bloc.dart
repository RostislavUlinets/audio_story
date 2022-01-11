import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'repeat_event.dart';
part 'repeat_state.dart';

class ButtonBloc extends Bloc<ButtonEvent, ButtonState> {
  ButtonBloc()
      : super(const ButtonInitialState(
          false,
          false,
        )) {
    on<ButtonCycleEvent>(_onCycle);
    on<ButtonPlayAllEvent>(_onPlayAll);
    on<ButtonStopEvent>(_onStop);
  }

  void _onCycle(ButtonCycleEvent event, Emitter<ButtonState> emit) {
    emit(const ButtonCycleState(
      true,
      false,
    ));
  }

  void _onPlayAll(ButtonPlayAllEvent event, Emitter<ButtonState> emit) {
    emit(const ButtonPlayAllState(
      false,
      true,
    ));
  }

  void _onStop(ButtonStopEvent event, Emitter<ButtonState> emit) {
    emit(const ButtonInitialState(
      false,
      false,
    ));
  }
}
