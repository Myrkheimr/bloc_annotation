import 'package:analyzer/dart/element/element.dart';
import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:bloc_annotation_gen/src/generators/base_generator.dart';
import 'package:bloc_annotation_gen/src/utils/class_utils.dart';
import 'package:bloc_annotation_gen/src/utils/string_utils.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class EventGenerator extends BaseGenerator<EventClass, Config> {
  const EventGenerator({super.config});

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

    final overrideToString = annotation.peek('overrideToString')!.boolValue;
    final overrideEquality = annotation.peek('overrideEquality')!.boolValue;

    final buffer = StringBuffer();

    final classElement = (element as ClassElement);

    final factories = classElement.constructors.where((c) => c.isFactory);

    for (final factory in factories) {
      final ctorName = factory.name; // "initial" or "loaded"
      final redirectName =
          factory.redirectedConstructor?.enclosingElement.name ??
          '_\$${element.name}${StringUtils.capitalizeFirstLetter(ctorName)}';

      // collect parameters
      final params = factory.formalParameters;

      buffer.writeln('class $redirectName extends ${element.name} {');

      // constructor
      final ctorParams = params.map((p) => 'this.${p.name}').join(', ');
      buffer.writeln('  const $redirectName($ctorParams);');

      // fields
      for (final p in params) {
        buffer.writeln('  final ${p.type.getDisplayString()} ${p.name};');
      }

      final fields = params
          .map((p) => (!p.isStatic && !p.isSynthetic) ? p.displayName : null)
          .nonNulls;

      if (overrideToString) {
        ClassUtils.generateToString(buffer, redirectName.substring(2), fields);
      }

      if (overrideEquality) {
        ClassUtils.generateHashCode(buffer, fields);
        ClassUtils.generateEquality(buffer, redirectName, fields);
      }

      buffer.writeln('}');
      buffer.writeln();
    }

    return buffer.toString();
  }
}

class Config {}
