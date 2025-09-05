import 'package:source_gen/source_gen.dart';

final class AnnotationInvalidNumberOfTypeParameters implements Exception {
  AnnotationInvalidNumberOfTypeParameters({
    required this.count,
    required this.expectedCount,
    required this.annotation,
  });

  final int count;

  final int expectedCount;

  final ConstantReader annotation;

  @override
  String toString() {
    final name = annotation.typeValue.getDisplayString();

    return '''
InvalidNumberOfTypeParameters: $name has $count type parameters.

Expected: Exactly $expectedCount type parameter for the state type.
Found: $count type parameter${count != 1 ? 's' : ''}.

${_fixMessage(name)}
        ''';
  }

  String _fixMessage(String name) {
    if (count == 0) {
      return '''
Fix: Add a type parameter:
  @$name <-- Here
''';
    }

    return '''
Fix: Remove extra type parameters:
  @$name <-- Here
        ''';
  }
}
