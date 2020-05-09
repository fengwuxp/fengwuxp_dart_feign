import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/src/signature/md5_signature_strategy.dart';

void main() {
  var apiSignatureStrategy = new Md5SignatureStrategy("appId", "appSecret", "channelCode");

  test("signature strategy", () async {
    var request = FeignRequest(requestId: "1", queryParams: {}, body: {"name": "张三", "id": 1}, headers: {});
    apiSignatureStrategy.sign(["name", "id"], request);

    print("$request");
  });
}
