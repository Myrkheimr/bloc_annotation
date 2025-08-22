import 'package:bloc_annotation/src/base_annotation.dart';
import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class CubitClass extends BaseAnnotation {
  const CubitClass({super.name, super.overrideToString, required this.state});

  /// Type of the state this cubit will be emitting.
  ///
  /// Consider using `Never` instead of `null` incase you do not want to provide any type information.
  final Type state;
}
