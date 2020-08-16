import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/http/http_media_type.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/abstract_http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_output_message.dart';
import 'package:logging/logging.dart';

/// 用于写入和读取 Content-Type 为[HttpMediaType.FORM_DATA]的数据
class FormDataHttpMessageConverter extends AbstractHttpMessageConverter {
  static const String _TAG = "FormDataHttpMessageConverter";
  static var _log = Logger(_TAG);

  static final _FORM_DATA = ContentType.parse(HttpMediaType.FORM_DATA);

  static final _MULTIPART_FORM_DATA = ContentType.parse(HttpMediaType.MULTIPART_FORM_DATA);

  FormDataHttpMessageConverter() : super([_FORM_DATA, _MULTIPART_FORM_DATA]);

  @override
  bool canRead(ContentType mediaType, {Serializer serializer}) {
    return false;
  }

  @override
  Future write(data, ContentType mediaType, HttpOutputMessage outputMessage) {
    if (data == null) {
      return Future.value();
    }
    if (mediaType.value == _FORM_DATA.value) {
      _writeFormData(data, outputMessage);
    } else {
      _writeMultipartFormData(data, outputMessage);
    }
  }

  void _writeFormData(data, HttpOutputMessage outputMessage) {
    _log.finer("write form data $data");
    var text = QueryStringParser.stringify(data);
    super.writeBody(text, _FORM_DATA, outputMessage);
  }

  // TODO 处理文件上传
  void _writeMultipartFormData(data, HttpOutputMessage outputMessage) {}
}
