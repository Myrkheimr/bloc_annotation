import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';

extension AnnotationX on Element {
  List<DartType> typeParametersOfAnnotation<T>() {
    final obj = TypeChecker.typeNamed(T).firstAnnotationOfExact(this)?.type;
    if (obj == null) return [];

    return (obj as InterfaceType).typeArguments;
  }
}
