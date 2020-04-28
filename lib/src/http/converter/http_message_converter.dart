import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/http/http_media_type.dart';

import '../http_input_message.dart';
import '../http_output_message.dart';

/// reference  Spring Framework org.springframework.http.converter.HttpMessageConverter
/// Strategy interface that specifies a converter that can convert from and to HTTP requests and responses.
abstract class HttpMessageConverter<T> {
  /// Indicates whether the given class can be read by this converter.
  /// [mediaType] the [HttpMediaType] media type to read (can be {@code null} if not specified);
  /// typically the value of a {@code Content-Type} header.
  bool canRead(ContentType mediaType, {Serializer serializer});

  /// Indicates whether the given class can be written by this converter.
  /// [mediaType] the [HttpMediaType] media type to read (can be {@code null} if not specified);
  /// typically the value of a {@code Content-Type} header.
  bool canWrite(ContentType mediaType, {Serializer serializer});

  /// Return the list of {@link [HttpMediaType]} objects supported by this converter.
  /// @return the list of supported media types, potentially an immutable copy
  List<ContentType> getSupportedMediaTypes();

  /// Read an object of the given type from the given input message, and returns it.
  /// @param serializer the type of object to return. This type must have previously been passed to the
  /// {@link #canRead canRead} method of this interface, which must have returned {@code true}.
  /// @param inputMessage the HTTP input message to read from
  /// @return the converted object
  /// @throws IOException in case of I/O errors
  /// @throws HttpMessageNotReadableException in case of conversion errors
  Future<E> read<E>(HttpInputMessage inputMessage, {Serializer<E> serializer, FullType specifiedType});

  /// Write an given object to the given output message.
  /// @param t the object to write to the output message. The type of this object must have previously been
  /// passed to the {@link #canWrite canWrite} method of this interface, which must have returned {@code true}.
  /// @param contentType the content type to use when writing. May be {@code null} to indicate that the
  /// default content type of the converter must be used. If not {@code null}, this media type must have
  /// previously been passed to the {@link #canWrite canWrite} method of this interface, which must have
  /// returned {@code true}.
  /// @param outputMessage the message to write to
  /// @throws IOException in case of I/O errors
  /// @throws HttpMessageNotWritableException in case of conversion errors
  Future write(T data, ContentType mediaType, HttpOutputMessage outputMessage);
}

/// A specialization of {@link [HttpMessageConverter]} that can convert an HTTP request
/// into a target object of a specified generic type and a source object of a specified
/// generic type into an HTTP response.
abstract class GenericHttpMessageConverter<T> implements HttpMessageConverter<T> {}
