import '../named_support.dart';

/// 将方法参数/请求对象的属性转换为查询字符串参数
class RequestParam implements Named {


  ///查询字符串参数名称 默认为标记字段的名称
  final String name;

  const RequestParam([this.name]);
}
