import '../named_support.dart';

/// target field
/// request part
/// Annotation that can be used to associate the part of a "multipart/form-data" request
/// with a method argument.
///
///  If the tagged "String" represents a file path,
///  the "File" type is by default one request part
class RequestPart implements Named {
  /// The name of the part in the {@link HttpMediaType.MULTIPART_FORM_DATA} request to bind to.
  final String name;

  const RequestPart(this.name);
}
