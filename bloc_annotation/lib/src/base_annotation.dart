abstract class BaseAnnotation {
  const BaseAnnotation({this.name, this.overrideToString = true});

  /// Optional custom name for the generated class
  /// If not provided, will use the annotated class name + 'Type' (Cubit, Bloc, Event, State)
  final String? name;

  /// Whether to generate & override toString methods
  final bool overrideToString;
}
