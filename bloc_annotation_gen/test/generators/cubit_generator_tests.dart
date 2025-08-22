// ignore_for_file: invalid_annotation_target

import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:source_gen_test/source_gen_test.dart';

@ShouldGenerate(r'''
import 'package:bloc/bloc.dart';

mixin class _$MyCubit<T> extends Cubit<T> {
  _$MyCubit(T initialState) : super(initialState);
}
''')
@CubitClass()
final class MyCubit {}

// Error test cases (these should NOT generate, but throw errors)

// This should throw an error - enum cannot be a cubit
@ShouldThrow(
  'CubitGenerator cannot target `TestEnum`. Only classes can be annotated with @cubit.',
)
@CubitClass()
enum TestEnum { value1, value2 }

// This should throw an error - function cannot be a cubit
@ShouldThrow(
  'CubitGenerator cannot target `testFunction`. Only classes can be annotated with @cubit.',
)
@CubitClass()
void testFunction() {}

// This should throw an error - variable cannot be a cubit
@ShouldThrow(
  'CubitGenerator cannot target `testVariable`. Only classes can be annotated with @cubit.',
)
@CubitClass()
const String testVariable = 'test';

// This should throw an error - typedef cannot be a cubit
@ShouldThrow(
  'CubitGenerator cannot target `TestTypedef`. Only classes can be annotated with @cubit.',
)
@CubitClass()
typedef TestTypedef = void Function();

// This should throw an error - mixin cannot be a cubit
@ShouldThrow(
  'CubitGenerator cannot target `TestMixin`. Only classes can be annotated with @cubit.',
)
@CubitClass()
mixin TestMixin {}
