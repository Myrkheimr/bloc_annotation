/// Base class for creating annotations with common options
abstract class BaseAnnotation {
  const BaseAnnotation({
    this.overrideToString = true,
    this.overrideEquality = true,
  });

  /// Whether to generate & override toString methods
  ///
  /// Defaults to `true`.
  final bool overrideToString;

  /// Whether to override [hashCode] & equality operator [==]
  ///
  /// Defaults to `true`.
  final bool overrideEquality;
}
