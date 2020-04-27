import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'title.g.dart';

abstract class Title implements Built<Title, TitleBuilder> {
  Title._();

  factory Title([updates(TitleBuilder b)]) = _$Title;

  @BuiltValueField(wireName: 'rendered')
  String get rendered;

  static Serializer<Title> get serializer => _$titleSerializer;
}
