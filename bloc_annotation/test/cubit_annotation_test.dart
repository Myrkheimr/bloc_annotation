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

      expect(annotation.overrideToString, isTrue);
      expect(annotation.overrideEquality, isTrue);
      expect(annotation.state, equals(int));
    });

    test('should override overrideToString parameter', () {
      const annotation = CubitClass(overrideToString: false, state: int);
      expect(annotation.overrideToString, isFalse);
    });

    test('should override overrideEquality parameter', () {
      const annotation = CubitClass(overrideEquality: false, state: int);
      expect(annotation.overrideEquality, isFalse);
    });

    test('should initializes with custom type', () {
      const annotation = CubitClass(state: _CustomState);
      expect(annotation.state, equals(_CustomState));
    });

    test('should override customizable parameters', () {
      const annotation = CubitClass(
        overrideToString: false,
        overrideEquality: false,
        state: Map<String, dynamic>,
      );

      expect(annotation.overrideToString, isFalse);
      expect(annotation.overrideEquality, isFalse);
      expect(annotation.state, equals(Map<String, dynamic>));
    });
  });
}
