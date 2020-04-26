

/// An exception caused by an error in a pkg/http client.
class RestClientException implements Exception {
  final String message;

  /// The URL of the HTTP request or response that failed.
  final Uri uri;

  RestClientException(this.message, [this.uri]);

  @override
  String toString() => message;
}
