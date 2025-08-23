import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

class BaseGenerator<A, C> extends GeneratorForAnnotation<A> {
  const BaseGenerator({this.config = const {}});

  final Map<String, dynamic> config;

  /// Verifies the annotation target
  ///
  /// throws [InvalidGenerationSource] exception if element doesn't match.
  void verifyElementKind({
    required ElementKind expected,
    required ElementKind got,
    Element? element,
  }) {
    if (expected != got) {
      throw InvalidGenerationSource(
        'Generator cannot target ${element?.name}'
        'Only ${expected.displayName} can be annotated with $A',
        element: element,
      );
    }
  }
}
