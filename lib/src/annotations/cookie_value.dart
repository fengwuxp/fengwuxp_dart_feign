import '../named_support.dart';

/// target field
///将方法参数/请求对象的属性转换为请求提交的cookie
class CookieValue implements Named {
  /// 提交的cookie值的名称，默认为标记字段的名称
  final String name;

  /// 是否必须，默认true
  final bool required;

  const CookieValue({String name: "", bool required: true})
      : this.name = name,
        this.required = required;
}
