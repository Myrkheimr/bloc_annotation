import 'package:bloc_annotation/src/base_annotation.dart';
import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class EventClass extends BaseAnnotation {
  const EventClass({super.overrideToString, this.copyWith = true});

  /// Whether to generate copyWith method (enabled by default)
  final bool copyWith;
}
