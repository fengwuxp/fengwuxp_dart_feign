import '../named_support.dart';

/// target field
/// 将方法参数/请求对象的属性转换为请求提交的路径参数
/// 例如：/test/${memberId} ==>  @PathVariable("memberId")
/// 只有简单类型能使用该注解  例如 num的子类 int double String  bool enum
/// path variable use '{}' surround, example :http://xxx.xx.com/api/getMember/{id}
class PathVariable implements Named{


  ///路径参数的名称，默认为标记字段的名称
  final String name;

  const PathVariable([this.name]);
}
