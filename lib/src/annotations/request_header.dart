import '../named_support.dart';

/// target field
/// 将方法参数/请求对象的属性转换为请求头
class RequestHeader implements Named{
  ///提交的请求头名称，默认为标记字段的名称
  final String name;

  /// 是否必须，默认true
  final bool required;

  const RequestHeader({String name: "", bool required: true})
      : this.name = name,
        this.required = required;
}
