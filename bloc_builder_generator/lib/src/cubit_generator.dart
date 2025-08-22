import 'package:analyzer/dart/element/element.dart';
import 'package:bloc_builder_annotation/bloc_builder_annotation.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class CubitGenerator extends GeneratorForAnnotation<CubitClass> {
  const CubitGenerator();

  @override
  generateForAnnotatedElement(
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

    final mixinName = '_\$${element.name}';

    return '''
import 'package:bloc/bloc.dart';

mixin class $mixinName<T> extends Cubit<T> {
  $mixinName(T initialState) : super(initialState);
}
''';
  }
}
