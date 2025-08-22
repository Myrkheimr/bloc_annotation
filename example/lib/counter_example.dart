import 'dart:io' as io;
import 'package:bloc/bloc.dart';
import 'package:bloc_annotation/bloc_annotation.dart';

part 'counter_example.g.dart';

@CubitClass(state: List<int>)
final class _CounterCubit extends _$_CounterCubit {
  _CounterCubit() : super([]);

  void increment() => emit([...state, (state.length) + 1]);

  void decrement() =>
      emit(state.sublist(0, (state.length - 1).clamp(0, state.length)));
  void reset() => emit([]);
}

void run() {
  final counter = _CounterCubit();

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
      counter.increment();
    } else if (input.toLowerCase() == 'd') {
      counter.decrement();
    } else if (input.toLowerCase() == 'r') {
      counter.reset();
    }
  }

  counter.close();
}
