abstract class FeignClientExecutor {
  /// execute proxy service method
  /// [methodName]
  /// [positionalArguments]
  /// [namedArguments]
  Future invoke(String methodName, List<dynamic> positionalArguments, [Map<Symbol, dynamic> namedArguments = const {}]);
}
