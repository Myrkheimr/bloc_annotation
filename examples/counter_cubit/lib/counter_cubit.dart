import 'package:bloc/bloc.dart';
import 'package:bloc_annotation/bloc_annotation.dart';

part 'counter_cubit.g.dart';

@CubitClass<int>()
final class CounterCubit extends _$CounterCubit {
  CounterCubit() : super(0);
}
