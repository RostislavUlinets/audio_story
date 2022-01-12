part of 'repeat_bloc.dart';

abstract class ButtonEvent extends Equatable {
  const ButtonEvent();

  @override
  List<Object> get props => [];
}

class ButtonCycleEvent extends ButtonEvent {
  const ButtonCycleEvent();
}

class ButtonPlayAllEvent extends ButtonEvent {
  const ButtonPlayAllEvent();
}

class ButtonStopEvent extends ButtonEvent {
  const ButtonStopEvent();
}
