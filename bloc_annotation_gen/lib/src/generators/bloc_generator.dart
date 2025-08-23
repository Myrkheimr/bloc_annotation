import 'package:analyzer/dart/element/element.dart';
import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:bloc_annotation_gen/src/generators/base_generator.dart';
import 'package:bloc_annotation_gen/src/types/config.dart';
import 'package:bloc_annotation_gen/src/utils/string_utils.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class BlocGenerator extends BaseGenerator<BlocClass, Config> {
  const BlocGenerator({super.config});

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element.kind != ElementKind.CLASS) {
      throw InvalidGenerationSource(
        'BlocGenerator cannot target `${element.name}`. '
        'Only classes can be annotated with @BlocClass.',
        element: element,
      );
    }

    final blocName = element.name;
    final stateType =
        annotation.peek('state')?.typeValue.getDisplayString() ?? 'dynamic';
    final eventType =
        annotation.peek('event')?.typeValue.getDisplayString() ?? 'dynamic';

    final buffer = StringBuffer();

    buffer.writeln(
      'abstract class _\$$blocName extends Bloc<$eventType, $stateType> {'
      '  _\$$blocName(super.initialState) {',
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
    }

    buffer.writeln('}');

    return buffer.toString();
  }
}
