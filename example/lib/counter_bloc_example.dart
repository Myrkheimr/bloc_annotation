import 'dart:io' as io;
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_annotation/bloc_annotation.dart';

part 'counter_bloc_example.g.dart';

@EventClass()
sealed class CounterEvent {
  const CounterEvent();

  const factory CounterEvent.incremented() = _$CounterEventIncremented;
  const factory CounterEvent.decremented() = _$CounterEventDecremented;
  const factory CounterEvent.reset() = _$CounterEventReset;
}

@BlocClass(event: CounterEvent, state: List<int>)
class CounterBloc extends _$CounterBloc {
  CounterBloc() : super([]);

  @override
  void onIncremented(event, emit) {
    emit([...state, state.length + 1]);
  }

  @override
  void onDecremented(event, emit) {
    emit(state.sublist(0, (state.length - 1).clamp(0, state.length)));
  }

  @override
  void onReset(event, emit) {
    emit([]);
  }
}

void run() async {
  final counter = CounterBloc();

  bool exit = false;

  while (!exit) {
    io.stdout.writeln('\x1B[2J\x1B[0;0H'); // clear screen
    io.stdout.writeln("Counter: ${counter.state}");
    io.stdout.writeln(
      "Enter 'q' to quit, 'a' to increment, 'd' to decrement, 'r' to reset",
    );

    final input = io.stdin.readLineSync() ?? "";

    if (input.toLowerCase() == 'q') {
      exit = true;
    } else if (input.toLowerCase() == 'a') {
      counter.add(CounterEvent.incremented());
    } else if (input.toLowerCase() == 'd') {
      counter.add(CounterEvent.decremented());
    } else if (input.toLowerCase() == 'r') {
      counter.add(CounterEvent.reset());
    }

    await Future.delayed(Duration.zero);
  }

  await counter.close();
}
