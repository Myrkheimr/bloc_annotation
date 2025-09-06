import 'package:bloc_annotation_generator/src/generators/generators.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

Builder cubitBuilder(BuilderOptions _) =>
    SharedPartBuilder([CubitAnnotationGenerator()], "cubit");
