import 'package:fengwuxp_dart_openfeign/src/constant/http/http_media_type.dart';

/// target param
/// mark parameter is request body
/// @see [HttpMediaType]
class RequestBody {

  /// Whether body content is required.
  /// <p>Default is {@code true}, leading to an exception thrown in case
  /// there is no body content. Switch this to {@code false} if you prefer
  /// {@code null} to be passed when the body content is {@code null}.
  final bool required;

  const RequestBody([bool required]) : this.required = required ?? true;
}
