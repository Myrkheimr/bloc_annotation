import 'package:bloc_annotation/bloc_annotation.dart';

@CubitClass(state: int)
final class CubitExample {}

@CubitClass(state: List<String>)
final class NamedCubitExample {}

@EventClass()
sealed class SomeEvent {}

@StateClass(sealed: false)
final class SomeState {}

@BlocClass(event: SomeEvent, state: SomeState)
final class SomeBloc {}

@StateClass()
sealed class SomeSealedState {
  // const factory SomeSealedState.initial() = _$SomeSealedInitialState;
  // const factory SomeSealedState.loading() = _$SomeSealedLoadingState;
  // const factory SomeSealedState.loaded(int data) = _$SomeSealedLoadedState;
  // const factory SomeSealedState.error(String message) = _$SomeSealedErrorState;
}
