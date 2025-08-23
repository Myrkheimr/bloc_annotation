import 'package:analyzer/dart/ast/ast.dart';

sealed class Config {
  const Config();

  factory Config.cubit({
    required Map<String, dynamic> config,
    required Annotation annotation,
  }) = CubitConfig.create;
}

final class CubitConfig extends Config {
  const CubitConfig();

  factory CubitConfig.create({
    required Map<String, dynamic> config,
    required Annotation annotation,
  }) {
    return CubitConfig();
  }
}
