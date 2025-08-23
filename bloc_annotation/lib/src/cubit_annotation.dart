import 'package:bloc_annotation/src/base_annotation.dart';
import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class CubitClass extends BaseAnnotation {
  const CubitClass({
    super.overrideToString,
    super.overrideEquality,
    required this.state,
  });

  /// Type of the state this cubit will be emitting.
  final Type state;
}
