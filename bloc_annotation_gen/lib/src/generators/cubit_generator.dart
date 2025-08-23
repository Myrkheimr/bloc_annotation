import 'package:analyzer/dart/element/element.dart';
import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:bloc_annotation_gen/src/generators/base_generator.dart';
import 'package:bloc_annotation_gen/src/types/config.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class CubitGenerator extends BaseGenerator<CubitClass, GeneratorConfig> {
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

    final cfg = GeneratorConfig.cubit(
      config: config,
      element: element,
      annotation: annotation,
    );

    return super.generateTemplate(cfg);
  }
}
