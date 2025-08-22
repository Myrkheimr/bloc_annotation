import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:test/test.dart';

void main() {
  group('StateClass Annotation', () {
    test('should create with default values', () {
      const annotation = StateClass();

      expect(annotation.name, isNull);
      expect(annotation.overrideToString, isTrue);
      expect(annotation.copyWith, isTrue);
    });

    test('should initialize with custom name', () {
      const annotation = StateClass(name: 'TestState');
      expect(annotation.name, equals("TestState"));
    });

    test('should override overrideToString parameter', () {
      const annotation = StateClass(overrideToString: false);
      expect(annotation.overrideToString, isFalse);
    });

    test('should override copyWith parameter', () {
      const annotation = StateClass(copyWith: false);
      expect(annotation.copyWith, isFalse);
    });

    test('should override customizable parameters', () {
      const annotation = StateClass(
        name: "MyState",
        overrideToString: false,
        copyWith: false,
      );

      expect(annotation.name, equals("MyState"));
      expect(annotation.overrideToString, isFalse);
      expect(annotation.copyWith, isFalse);
    });
  });
}
