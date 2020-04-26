import 'package:fengwuxp_dart_openfeign/src/match/simple_path_matcher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('simple path matcher', () {
    const pathMatcher = SimplePathMatcher();

    void match(String pattern, List<String> paths) {
      var result = paths.map((path) {
        return pathMatcher.match(pattern, path);
      }).join(" ");
      print("$pattern  $result");
    }

    match('/path/**', ['http://abc.d/path/x/y/z/xyz', '/paths/x/y/z/xyy']);
    match('/**/path', ['http://abc.d/abc/path', '/abc/path1', '/abc/path/2']);
    match('/**/path/**', ['http://abc.d/abc/path/test', '/abc/path1/hhh', '/abc/path']);
    match('/api/**/user/refreshToken', ['http://abc.d/api/1.0.0/user/refreshToken', '/abc/path1/hhh', '/abc/path']);
    match('/app/**/user/login',
        ['http://xx.xx:52001/app/v1.0/user/login', 'http://abc.d/app/1.0.0/user/login', '/abc/path1/hhh', '/abc/path']);
    match('/app/**/user/authCode', [
      'http://xx.xx:52001/app/v1.0/user/authCode',
      'http://abc.d/app/1.0.0/user/login',
      '/abc/path1/hhh',
      '/abc/path'
    ]);
  });

  test("test runtime generic", () {
    List getList() {
      List<String> list = ["111"];

      return list;
    }

    var list2 = getList();
    print(list2);

  });
}
