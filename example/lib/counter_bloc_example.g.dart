// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_bloc_example.dart';

// **************************************************************************
// BlocGenerator
// **************************************************************************

abstract class _$CounterBloc extends Bloc<CounterEvent, List<int>> {
  _$CounterBloc(super.initialState) {
    on<_$CounterEventIncremented>(_onIncremented);
    on<_$CounterEventDecremented>(_onDecremented);
    on<_$CounterEventReset>(_onReset);
  }
  FutureOr<void> _onIncremented(
    _$CounterEventIncremented event,
    Emitter<List<int>> emit,
  ) => onIncremented(event, emit);
  FutureOr<void> onIncremented(
    _$CounterEventIncremented event,
    Emitter<List<int>> emit,
  );

  FutureOr<void> _onDecremented(
    _$CounterEventDecremented event,
    Emitter<List<int>> emit,
  ) => onDecremented(event, emit);
  FutureOr<void> onDecremented(
    _$CounterEventDecremented event,
    Emitter<List<int>> emit,
  );

  FutureOr<void> _onReset(_$CounterEventReset event, Emitter<List<int>> emit) =>
      onReset(event, emit);
  FutureOr<void> onReset(_$CounterEventReset event, Emitter<List<int>> emit);
}

// **************************************************************************
// EventGenerator
// **************************************************************************

class _$CounterEventIncremented extends CounterEvent {
  const _$CounterEventIncremented();
}

class _$CounterEventDecremented extends CounterEvent {
  const _$CounterEventDecremented();
}

class _$CounterEventReset extends CounterEvent {
  const _$CounterEventReset();
}
