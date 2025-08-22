import 'package:bloc_annotation/src/base_annotation.dart';
import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class CubitClass extends BaseAnnotation {
  const CubitClass({super.name, super.overrideToString});
}

const cubit = CubitClass();
