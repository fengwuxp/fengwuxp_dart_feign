import 'dart:async';
import 'dart:io';

import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/built_value_http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_input_message.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import '../../built/hello/hello.dart';
import '../../built/serializers.dart';
import 'json_object_http_message_converter.dart';

class InputStreamHttpInputMessage implements HttpInputMessage {

  ByteStream _inputStream;

  InputStreamHttpInputMessage(Stream<List<int>> source) : this._inputStream = ByteStream(source);

  @override
  ByteStream get body => _inputStream;

  @override
  Map<String, String> get headers => {};
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
      var result = await jsonObjectHttpMessageConverter.read(inputMessage, serializeType: Hello);
      print("===> $result");
    }
  });

  test('test  built http message converter', () async {
    var codeUnits = jsonText.codeUnits;
    var inputMessage = new InputStreamHttpInputMessage(Stream.value(codeUnits));
    var builtValueHttpMessageConverter = BuiltValueHttpMessageConverter(new BuiltJsonSerializers(serializers), null);
    if (builtValueHttpMessageConverter.canRead(ContentType.json)) {
      Hello result = await builtValueHttpMessageConverter.read(inputMessage, serializeType: Hello);
      print("==Hello=> $result");
    }
  });
}
