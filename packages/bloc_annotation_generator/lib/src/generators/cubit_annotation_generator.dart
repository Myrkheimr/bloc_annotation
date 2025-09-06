import 'package:analyzer/dart/element/element.dart';
import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:bloc_annotation_generator/src/utils/utils.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

final class CubitAnnotationGenerator
    extends GeneratorForAnnotation<CubitClass> {
  const CubitAnnotationGenerator();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    GeneratorUtils.isElementOfKindOrThrow(
      element: element,
      kind: ElementKind.CLASS,
    );

    final ce = (element as ClassElement);

    final className = ce.displayName;

    final stateType = element
        .typeParametersOfAnnotation<CubitClass>()
        .map((t) => t.getDisplayString())
        .firstOrNull;

    return '''
abstract interface class _\$$className extends Cubit<$stateType> {
  _\$$className(super.initialState);
}
''';
  }
}
