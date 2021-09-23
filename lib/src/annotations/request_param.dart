import '../named_support.dart';

/// 将方法参数/请求对象的属性转换为查询字符串参数
class RequestParam implements Named {
  ///查询字符串参数名称 默认为标记字段的名称
  final String name;

  /// 是否必须，默认true
  final bool required;

  // 默认值
  final String? defaultValue;

  const RequestParam(
      {String name: "", bool required: true, String? defaultValue})
      : this.name = name,
        this.required = required,
        this.defaultValue = defaultValue;
}
