import 'package:analyzer/dart/element/element.dart';
import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

String _capitalize(String? input) {
  if (input == null || input.isEmpty) return "";

  return '${input[0].toUpperCase()}${input.substring(1)}';
}

class BlocGenerator extends GeneratorForAnnotation<BlocClass> {
  const BlocGenerator();

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
            '_\$${eventClass.name}${_capitalize(ctorName)}';

        final eventName = redirectName;
        final methodName = 'on${_capitalize(ctorName)}';

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
            '_\$${eventClass.name}${_capitalize(ctorName)}';

        final eventName = redirectName;
        final methodName = 'on${_capitalize(ctorName)}';

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
