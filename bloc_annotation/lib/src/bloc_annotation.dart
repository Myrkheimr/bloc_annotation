import 'package:bloc_annotation/src/base_annotation.dart';
import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class BlocClass extends BaseAnnotation {
  const BlocClass({
    super.overrideToString,
    required this.event,
    required this.state,
  });

  final Type event;
  final Type state;
}
