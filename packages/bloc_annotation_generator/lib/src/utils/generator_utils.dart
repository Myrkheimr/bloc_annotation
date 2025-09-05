import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

abstract final class GeneratorUtils {
  static bool isElementOfKind({
    required Element element,
    required ElementKind expected,
  }) => element.kind == expected;

  static void isElementOfKindOrThrow({
    required Element element,
    required ElementKind kind,
  }) {
    if (isElementOfKind(element: element, expected: kind)) return;

    throw InvalidGenerationSource(
      'Generator cannot target ${element.displayName}'
      'Only ${kind.displayName} can be annotated',
      element: element,
    );
  }
}
