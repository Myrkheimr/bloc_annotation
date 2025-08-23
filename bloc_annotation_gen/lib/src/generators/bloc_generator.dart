import 'package:analyzer/dart/element/element.dart';
import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:bloc_annotation_gen/src/generators/base_generator.dart';
import 'package:bloc_annotation_gen/src/types/config.dart';
import 'package:bloc_annotation_gen/src/utils/class_utils.dart';
import 'package:bloc_annotation_gen/src/utils/string_utils.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class BlocGenerator extends BaseGenerator<BlocClass, GeneratorConfig> {
  const BlocGenerator({super.config});

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

    final name = "_\$${element.name}";
    final stateType =
        annotation.peek('state')?.typeValue.getDisplayString() ?? 'dynamic';
    final eventType =
        annotation.peek('event')?.typeValue.getDisplayString() ?? 'dynamic';
    final overrideToString = annotation.peek('overrideToString')!.boolValue;
    final overrideEquality = annotation.peek('overrideEquality')!.boolValue;

    final buffer = StringBuffer();

    buffer.writeln(
      'abstract class $name extends Bloc<$eventType, $stateType> {'
      '  $name(super.initialState) {',
    );

    final eventClass = annotation.peek('event')?.typeValue.element;
    if (eventClass is ClassElement) {
      final factories = eventClass.constructors.where((c) => c.isFactory);
      for (final f in factories) {
        final ctorName = f.name;
        final redirectName =
            f.redirectedConstructor?.enclosingElement.name ??
            '_\$${eventClass.name}${StringUtils.capitalizeFirstLetter(ctorName)}';

        final eventName = redirectName;
        final methodName = 'on${StringUtils.capitalizeFirstLetter(ctorName)}';

        buffer.writeln("    on<$eventName>(_$methodName);");
      }
    }

    buffer.writeln(
      '  }'
      '',
    );

    if (eventClass is ClassElement) {
      final factories = eventClass.constructors.where((c) => c.isFactory);
      for (final f in factories) {
        final ctorName = f.name;
        final redirectName =
            f.redirectedConstructor?.enclosingElement.name ??
            '_\$${eventClass.name}${StringUtils.capitalizeFirstLetter(ctorName)}';

        final eventName = redirectName;
        final methodName = 'on${StringUtils.capitalizeFirstLetter(ctorName)}';

        buffer.writeln(
          '  FutureOr<void> _$methodName($eventName event, Emitter<$stateType> emit) => $methodName(event, emit);',
        );

        buffer.writeln(
          '  FutureOr<void> $methodName($eventName event, Emitter<$stateType> emit);',
        );

        buffer.writeln("\n");
      }

      final fields = (element as ClassElement).fields
          .map((f) => (!f.isStatic && !f.isSynthetic) ? f.displayName : null)
          .nonNulls;

      if (overrideToString) {
        ClassUtils.generateToString(buffer, name.substring(2), fields);
      }

      if (overrideEquality) {
        ClassUtils.generateHashCode(buffer, fields);
        ClassUtils.generateEquality(buffer, name.substring(2), fields);
      }
    }

    buffer.writeln('}');

    return buffer.toString();
  }
}
