import 'package:analyzer/dart/element/element.dart';
import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:bloc_annotation_gen/src/generators/base_generator.dart';
import 'package:bloc_annotation_gen/src/types/config.dart';
import 'package:bloc_annotation_gen/src/utils/class_utils.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class CubitGenerator extends BaseGenerator<CubitClass, Config> {
  const CubitGenerator({super.config});

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    super.verifyElementKind(
      expected: ElementKind.CLASS,
      got: element.kind,
      element: element,
    );

    final name = '_\$${element.name}';
    final stateType = annotation.peek('state')?.typeValue.getDisplayString();
    final overrideToString = annotation.peek('overrideToString')!.boolValue;
    final overrideEquality = annotation.peek('overrideEquality')!.boolValue;

    final fields = (element as ClassElement).fields
        .map((f) => (!f.isStatic && !f.isSynthetic) ? f.displayName : null)
        .nonNulls;

    final buffer = StringBuffer();

    buffer.writeln('class $name extends Cubit<$stateType> {');
    buffer.writeln('\t$name(super.initialState);');

    if (overrideToString) {
      ClassUtils.generateToString(buffer, name.substring(2), fields);
    }

    if (overrideEquality) {
      ClassUtils.generateHashCode(buffer, fields);
      ClassUtils.generateEquality(buffer, name.substring(2), fields);
    }

    buffer.writeln('}');
    return buffer.toString();
  }
}
