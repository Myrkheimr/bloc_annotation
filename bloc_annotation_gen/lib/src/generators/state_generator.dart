import 'package:analyzer/dart/element/element.dart';
import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:bloc_annotation_gen/src/generators/base_generator.dart';
import 'package:bloc_annotation_gen/src/types/config.dart';
import 'package:bloc_annotation_gen/src/utils/string_utils.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class StateGenerator extends BaseGenerator<StateClass, Config> {
  const StateGenerator({super.config});

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element.kind != ElementKind.CLASS) {
      throw InvalidGenerationSource(
        'StateGenerator cannot target `${element.name}`. '
        'Only classes can be annotated with @StateClass.',
        element: element,
      );
    }

    final buffer = StringBuffer();

    final classElement = (element as ClassElement);

    final factories = classElement.constructors.where((c) => c.isFactory);

    for (final factory in factories) {
      final ctorName = factory.name;
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

      // copyWith if enabled
      // if (annotation.peek('copyWith')?.boolValue ?? true) {
      //   final copyParams = params
      //       .map((p) {
      //         final type = p.type.getDisplayString(withNullability: true);
      //         return '$type? ${p.name}';
      //       })
      //       .join(', ');
      //   final copyBody = params
      //       .map((p) {
      //         return '${p.name} ?? this.${p.name}';
      //       })
      //       .join(', ');
      //   buffer.writeln(
      //     '  $redirectName copyWith({$copyParams}) => $redirectName($copyBody);',
      //   );
      // }

      buffer.writeln('}');
      buffer.writeln();
    }

    return buffer.toString();
  }
}
