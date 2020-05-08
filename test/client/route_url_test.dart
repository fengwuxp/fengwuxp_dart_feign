import 'package:fengwuxp_dart_openfeign/src/context/request_url_mapping_holder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test normalize url', () {
    var url = Uri.parse("@default/h//test/a");
    print(url.scheme);
    print(url.host);
//    url = url.replace(scheme: "https", host: "www.test.com");
    url = url.resolve("http://www.test.com//h//test/a");
    print(url.scheme);
    print(url.host);
    print("$url");
    print(normalizeUrl("http://www.test.com//h//test/a"));
  });

  test('test routing url', () {
    var url = routing(Uri.parse("@default//h//test/a?a=2&b=2&c=3"), {"default": "http://www.test.com"});
    print("$url");
  });
}
