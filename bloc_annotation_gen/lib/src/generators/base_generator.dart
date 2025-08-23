import 'package:source_gen/source_gen.dart';

class BaseGenerator<A, C> extends GeneratorForAnnotation<A> {
  const BaseGenerator({this.config = const {}});

  final Map<String, dynamic> config;
}
