import '../named_support.dart';

/// target field
/// 将方法参数/请求对象的属性转换为请求头
class RequestHeader implements Named{
  ///提交的请求头名称，默认为标记字段的名称
  final String name;

  const RequestHeader([this.name ]);
}
