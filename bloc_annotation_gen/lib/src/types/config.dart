import 'package:analyzer/dart/element/element.dart';
import 'package:bloc_annotation_gen/src/utils/class_utils.dart';
import 'package:source_gen/source_gen.dart';

sealed class GeneratorConfig {
  const GeneratorConfig();

  factory GeneratorConfig.cubit({
    required Map<String, dynamic> config,
    required Element element,
    required ConstantReader annotation,
  }) = CubitConfig.create;
}

final class ClassConfig {
  const ClassConfig({required this.fieldMap});

  final Map<String, String> fieldMap;

  static const empty = ClassConfig(fieldMap: {});

  factory ClassConfig.fromElement(Element element) {
    final fieldMap = ClassUtils.getFields(element);

    return ClassConfig(fieldMap: fieldMap);
  }
}

final class CubitConfig extends GeneratorConfig {
  const CubitConfig({
    required this.rawName,
    required this.name,
    required this.overrideEquality,
    required this.overrideToString,
    required this.state,
    required this.cls,
    required this.isClass,
  });

  final String rawName;
  final String name;
  final bool overrideEquality;
  final bool overrideToString;
  final String state;
  final ClassConfig cls;
  final bool isClass;

  factory CubitConfig.create({
    required Map<String, dynamic> config,
    required Element element,
    required ConstantReader annotation,
  }) {
    final cls = element.kind == ElementKind.CLASS
        ? ClassConfig.fromElement(element)
        : ClassConfig.empty;
    final isClass = cls == ClassConfig.empty;

    return CubitConfig(
      rawName: element.displayName,
      name: "_\$${element.displayName}",
      overrideEquality: annotation.peek('overrideEquality')!.boolValue,
      overrideToString: annotation.peek('overrideToString')!.boolValue,
      state: annotation.peek('state')!.typeValue.getDisplayString(),
      cls: cls,
      isClass: isClass,
    );
  }
}
