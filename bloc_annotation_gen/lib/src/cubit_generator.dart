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
        'Only classes can be annotated with @CubitClass.',
        element: element,
      );
    }

    final customName = annotation.peek('name')?.stringValue;

    final name = '_\$${customName ?? element.name}';

    final stateType = annotation.peek('state')?.typeValue.getDisplayString();

    return '''
    class $name extends Cubit<$stateType> {
      $name(super.initialState);
    }
    ''';
  }
}
