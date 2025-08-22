import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:test/test.dart';

void main() {
  group('CubitClass Annotation', () {
    test('should create with default values', () {
      const annotation = CubitClass();

      expect(annotation.name, isNull);
      expect(annotation.overrideToString, isTrue);
    });

    test('should initialize with custom name', () {
      const annotation = CubitClass(name: 'TestCubit');
      expect(annotation.name, equals("TestCubit"));
    });

    test('should override overrideToString parameter', () {
      const annotation = CubitClass(overrideToString: false);
      expect(annotation.overrideToString, isFalse);
    });

    test('should override customizable parameters', () {
      const annotation = CubitClass(name: "MyCubit", overrideToString: false);

      expect(annotation.name, equals("MyCubit"));
      expect(annotation.overrideToString, isFalse);
    });
  });
}
