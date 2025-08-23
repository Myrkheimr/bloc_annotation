import 'package:analyzer/dart/element/element.dart';

abstract final class ClassUtils {
  /// Generates a `toString` method implementation.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// String toString() => 'MyClass(field1: field1, field2: field2)';
  /// ```
  static void generateToString(
    StringBuffer buffer,
    String className,
    Iterable<String> fieldNames,
  ) {
    buffer.writeln('');
    buffer.writeln('@override');
    buffer.writeln("String toString() {");
    buffer.write("  return '$className(");
    buffer.write(fieldNames.map((f) => "$f: \$$f").join(', '));
    buffer.writeln(")';");
    buffer.writeln("}");
  }

  /// Generates an equality operator (`==`) implementation.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// bool operator ==(covariant MyClass other) {
  ///   if (identical(this, other)) return true;
  ///
  ///   return other is this &&
  ///     other.field1 == field1 &&
  ///     ...;
  /// }
  /// ```
  static void generateEquality(
    StringBuffer buffer,
    String className,
    Iterable<String> fieldNames,
  ) {
    buffer.writeln('');
    buffer.writeln('@override');
    buffer.writeln("bool operator ==(Object other) {");

    buffer.writeln("  if (identical(this, other)) return true;");
    buffer.writeln("  return other is $className");

    for (final field in fieldNames) {
      buffer.writeln("    && other.$field == $field");
    }
    buffer.writeln("  ;");
    buffer.writeln("}");
  }

  /// Generates a `hashCode` implementation consistent with `==`.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// int get hashCode => Object.hashAll([field1, field2, ...]);
  /// ```
  static void generateHashCode(
    StringBuffer buffer,
    Iterable<String> fieldNames,
  ) {
    buffer.writeln('');
    buffer.writeln('@override');
    buffer.write('int get hashCode => Object.hashAll([');
    buffer.write(fieldNames.join(', '));
    buffer.writeln(']);');
  }

  static Map<String, String> getFields(Element element) {
    if (element.kind != ElementKind.CLASS) {
      throw Exception(
        '`ClassUtils.getFields` Expected [element] to be of type [class] got [${element.kind.displayName}]',
      );
    }

    final classElem = element as ClassElement;

    return {
      for (final field in classElem.fields)
        if (!field.isStatic && !field.isSynthetic)
          field.displayName: field.type.getDisplayString(),
    };
  }
}
