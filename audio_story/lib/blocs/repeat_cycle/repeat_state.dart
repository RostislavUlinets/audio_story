part of 'repeat_bloc.dart';

class ButtonState extends Equatable {
  final bool buttonCycle;
  final bool buttonPlayAll;

  const ButtonState({
    required this.buttonPlayAll,
    required this.buttonCycle,
  });

  @override
  List<Object> get props => [buttonPlayAll, buttonCycle];

  @override
  String toString() => 'ButtonInitial { button: $props }';
}

class ButtonInitialState extends ButtonState {
  const ButtonInitialState(bool buttonCycle, bool buttonPlayAll)
      : super(buttonCycle: buttonCycle, buttonPlayAll: buttonPlayAll);
}

class ButtonCycleState extends ButtonState {
  const ButtonCycleState(bool buttonCycle, bool buttonPlayAll)
      : super(buttonCycle: buttonCycle, buttonPlayAll: buttonPlayAll);
}

class ButtonPlayAllState extends ButtonState {
  const ButtonPlayAllState(bool buttonCycle, bool buttonPlayAll)
      : super(buttonCycle: buttonCycle, buttonPlayAll: buttonPlayAll);
}

// class ButtonRebuildState extends ButtonState {
//   const ButtonRebuildState(bool buttonCycle, bool buttonPlayAll)
//       : super(buttonCycle: buttonCycle, buttonPlayAll: buttonPlayAll);
// }
