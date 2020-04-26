import 'dart:async';
import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/http/http_media_type.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/built_value_http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_input_message.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../built/hello/hello.dart';
import '../../built/serializers.dart';
import 'json_object_http_message_converter.dart';

class InputStreamHttpInputMessage implements HttpInputMessage {
  StreamController<List<int>> _inputStream;

  /// The sink to which to write data that will be sent as the request body.
  ///
  /// This may be safely written to before the request is sent; the data will be
  /// buffered.
  ///
  /// Closing this signals the end of the request.
  EventSink<List<int>> get sink => _inputStream.sink;

  InputStreamHttpInputMessage(Stream<List<int>> source) {
    this._inputStream = new StreamController();
    this._inputStream.addStream(source);
  }

  StreamController get body => _inputStream;

  HttpHeaders get headers => null;
}

void main() {
  String jsonText = '''
 {
      "id": 157538,
      "date": "2017-07-21T10:30:34",
      "date_gmt": "2017-07-21T17:30:34",
      "type": "post",
      "link": "https://example.com",
      "title": {
          "rendered": "Json 2 dart built_value converter"
      },
      "tags": [
          1798,
          6298
      ]
    }
    ''';

  test('test  json http message converter', () async {
    var codeUnits = jsonText.codeUnits;
    var inputMessage = new InputStreamHttpInputMessage(Stream.value(codeUnits));
    JsonObjectHttpMessageConverter jsonObjectHttpMessageConverter = new JsonObjectHttpMessageConverter();
    if (jsonObjectHttpMessageConverter.canRead(ContentType.json)) {
      var result = await jsonObjectHttpMessageConverter.read(inputMessage, serializer: Hello.serializer);
      print("===> $result");
    }
  });

  test('test  built http message converter', () async {
    var codeUnits = jsonText.codeUnits;
    var inputMessage = new InputStreamHttpInputMessage(Stream.value(codeUnits));
    var builtValueHttpMessageConverter = BuiltValueHttpMessageConverter(serializers);
    if (builtValueHttpMessageConverter.canRead(ContentType.json)) {
      Hello result = await builtValueHttpMessageConverter.read(inputMessage, serializer: Hello.serializer);
      print("==Hello=> $result");
    }
  });
}
