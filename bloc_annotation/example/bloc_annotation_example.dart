import 'package:bloc_annotation/bloc_annotation.dart';

@CubitClass(state: int)
final class CubitExample {}

@CubitClass(name: "MyCustomCubit", state: List<String>)
final class NamedCubitExample {}
