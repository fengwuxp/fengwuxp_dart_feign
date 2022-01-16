import 'dart:convert';

import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/client/rest_response_extractor.dart';
import 'package:fengwuxp_dart_openfeign/src/http/streamed_client_http_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import '../built/serializers.dart';
import '../cms/enums/article_action_type.dart';
import '../cms/info/article_action_info.dart';

void main() {
  final builtJsonSerializers = new BuiltJsonSerializers(serializers);
  final httpMessageConverterExtractor = HttpMessageConverterExtractor([
    new BuiltValueHttpMessageConverter(builtJsonSerializers, (responseBody) {
      return Future.value(responseBody);
    })
  ]);

  test('test extractor response', () async {
    final articleActionInfo = new ArticleActionInfo((builder) => builder
      ..id = 1
      ..articleId = 2
      ..actionType = ArticleActionType.COLLECTION
      ..sourceCode = "1"
      ..crateTime = DateTime.utc(2022));

    final json = builtJsonSerializers.toJson(articleActionInfo);
    final bytes = json?.codeUnits ?? [];
    final data = Stream.value(bytes);

    Map<String, String> headers = {"content-length": "${bytes.length}", "content-type": "application/json"};
    final result = await httpMessageConverterExtractor.extractData(
      new StreamedClientHttpResponse(new StreamedResponse(data, 200, contentLength: bytes.length, headers: headers)),
      serializeType: ArticleActionInfo,
    );
    expect(result, articleActionInfo);
  });
}
