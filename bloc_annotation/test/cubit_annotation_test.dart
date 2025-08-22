import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:test/test.dart';

final class _CustomState {
  const _CustomState({required this.test, required this.value});

  final bool test;
  final int value;
}

void main() {
  group('CubitClass Annotation', () {
    test('should create with default values', () {
      const annotation = CubitClass(state: int);

      expect(annotation.name, isNull);
      expect(annotation.overrideToString, isTrue);
      expect(annotation.state, equals(int));
    });

    test('should initialize with custom name', () {
      const annotation = CubitClass(name: 'TestCubit', state: int);
      expect(annotation.name, equals("TestCubit"));
    });

    test('should override overrideToString parameter', () {
      const annotation = CubitClass(overrideToString: false, state: int);
      expect(annotation.overrideToString, isFalse);
    });

    test('should initializes with custom type', () {
      const annotation = CubitClass(state: _CustomState);
      expect(annotation.state, equals(_CustomState));
    });

    test('should override customizable parameters', () {
      const annotation = CubitClass(
        name: "MyCubit",
        overrideToString: false,
        state: int,
      );

      expect(annotation.name, equals("MyCubit"));
      expect(annotation.overrideToString, isFalse);
    });
  });
}
