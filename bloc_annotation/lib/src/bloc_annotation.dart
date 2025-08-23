import 'package:bloc_annotation/src/base_annotation.dart';
import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class BlocClass extends BaseAnnotation {
  const BlocClass({
    super.overrideToString,
    super.overrideEquality,
    required this.event,
    required this.state,
  });

  /// Type of the event this bloc will be emitting
  final Type event;

  /// Type of the state this bloc will be emitting
  final Type state;
}
