import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:test/test.dart';

void main() {
  group('StateClass Annotation', () {
    test('should create with default values', () {
      const annotation = StateClass();

      expect(annotation.overrideToString, isTrue);
      expect(annotation.overrideEquality, isTrue);
      expect(annotation.copyWith, isTrue);
      expect(annotation.sealed, isTrue);
    });

    test('should override overrideToString parameter', () {
      const annotation = StateClass(overrideToString: false);
      expect(annotation.overrideToString, isFalse);
    });

    test('should override overrideEquality parameter', () {
      const annotation = StateClass(overrideEquality: false);
      expect(annotation.overrideEquality, isFalse);
    });

    test('should override copyWith parameter', () {
      const annotation = StateClass(copyWith: false);
      expect(annotation.copyWith, isFalse);
    });

    test('should override sealed parameter', () {
      const annotation = StateClass(sealed: false);
      expect(annotation.sealed, isFalse);
    });

    test('should override customizable parameters', () {
      const annotation = StateClass(
        overrideToString: false,
        overrideEquality: false,
        copyWith: false,
        sealed: false,
      );

      expect(annotation.overrideToString, isFalse);
      expect(annotation.overrideEquality, isFalse);
      expect(annotation.copyWith, isFalse);
      expect(annotation.sealed, isFalse);
    });
  });
}
