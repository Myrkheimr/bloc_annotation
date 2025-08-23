import 'package:bloc_annotation/src/base_annotation.dart';
import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class StateClass extends BaseAnnotation {
  const StateClass({
    super.overrideToString,
    super.overrideEquality,
    this.copyWith = true,
    this.sealed = true,
  });

  /// Whether to generate copyWith method
  ///
  /// Defaults to `true`.
  final bool copyWith;

  /// Whether this is a sealed class with subclass-hierarchy or a standalone class
  ///
  /// Defaults to `true`.
  final bool sealed;
}
