import 'package:bloc_annotation_gen/src/types/config.dart';
import 'package:bloc_annotation_gen/src/utils/class_utils.dart';

String cubitTemplate(CubitConfig config) {
  final buffer = StringBuffer();

  final name = config.rawName;
  final generatedName = config.name;
  final state = config.state;

  buffer.writeln('class $generatedName extends Cubit<$state> {');
  buffer.writeln('\t$generatedName(super.initialState);');

  final fields = switch (config.isClass) {
    true => config.cls.fieldMap.keys,
    false => <String>[],
  };

  if (config.overrideToString) {
    ClassUtils.generateToString(buffer, name, fields);
  }

  if (config.overrideEquality) {
    ClassUtils.generateHashCode(buffer, fields);
    ClassUtils.generateEquality(buffer, generatedName.substring(2), fields);
  }

  buffer.writeln('}');

  return buffer.toString();
}
