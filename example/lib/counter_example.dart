import 'dart:io' as io;
import 'package:bloc/bloc.dart';
import 'package:bloc_annotation/bloc_annotation.dart';

part 'counter_example.g.dart';

@CubitClass()
final class _CounterCubit extends _$_CounterCubit {
  _CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
  void reset() => emit(0);
}

void run() {
  final counter = _CounterCubit();

  bool exit = false;

  while (!exit) {
    io.stdout.writeln('\x1B[2J\x1B[0;0H');
    io.stdout.writeln(
      "Counter: ${counter.state}\n\nEnter 'q' to quit\nEnter 'a' to increment counter\nEnter 'd' to derecement counter\nEnter 'r' to reset counter.",
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
