import 'package:fengwuxp_dart_openfeign/src/context/request_url_mapping_holder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test normalize url', () {
    expect(normalizeUrl("http://www.test.com//h//test/a"), "http://www.test.com/h/test/a");
  });

  test('test routing url', () {
    expect(routing(Uri.parse("lb://default//h//test/a?a=2&b=2&c=3"), {"default": "http://www.test.com"}).toString(),
        "http://www.test.com/h/test/a?a=2&b=2&c=3");
    expect(routing(Uri.parse("lb://default//h//abc"), {"default": "https://www.test.com"}).toString(),
        "https://www.test.com/h/abc");
    expect(routing(Uri.parse("http://default//h//abc"), {"default": "https://www.test.com"}).toString(),
        "http://default//h//abc");
  });
}
