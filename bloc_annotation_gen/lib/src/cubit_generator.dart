import 'package:analyzer/dart/element/element.dart';
import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class CubitGenerator extends GeneratorForAnnotation<CubitClass> {
  const CubitGenerator();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element.kind != ElementKind.CLASS) {
      throw InvalidGenerationSource(
        'CubitGenerator cannot target `${element.name}`. '
        'Only classes can be annotated with @cubit.',
        element: element,
      );
    }

    final classElement = element as ClassElement;

    final name = '_\$${classElement.name}';

    final stateType = 'int';

    return '''
    class $name extends Cubit<$stateType> {
      $name(super.initialState);
    }
    ''';
  }
}
