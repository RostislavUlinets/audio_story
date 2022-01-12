import 'package:bloc/bloc.dart';

import 'delete_event.dart';
import 'delete_state.dart';



class MyBloc extends Bloc<MyEvent, MyState> {
  MyBloc() : super(StateA()) {
    on<EventA>((event, emit) => emit(StateA()));
    on<EventB>((event, emit) => emit(StateB()));
  }
}