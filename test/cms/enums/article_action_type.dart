import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'article_action_type.g.dart';

class ArticleActionType extends EnumClass /*implements DescriptiveEnum*/ {

//  final String desc;

//  static const _DESC_MAP = {
//    "VIEW": "阅读",
//    "LIKE": "点赞",
//    "COMMENT": "评论",
//    "COLLECTION": "收藏",
//    "SHARE": "分享",
//  };

  static Serializer<ArticleActionType> get serializer => _$articleActionTypeSerializer;

  static const ArticleActionType VIEW = _$VIEW;
  static const ArticleActionType LIKE = _$LIKE;
  static const ArticleActionType COMMENT = _$COMMENT;
  static const ArticleActionType COLLECTION = _$COLLECTION;
  static const ArticleActionType SHARE = _$SHARE;

//  static const ArticleActionType VIEW =  const ArticleActionType._('VIEW', "阅读");
//  static const ArticleActionType LIKE =  const ArticleActionType._('LIKE', "点赞");
//  static const ArticleActionType COMMENT = const ArticleActionType._('COMMENT', "评论");
//  static const ArticleActionType COLLECTION = const ArticleActionType._('COLLECTION', "收藏");
//  static const ArticleActionType SHARE = const ArticleActionType._('SHARE', "分享");

  const ArticleActionType._(String name):super(name);

  static BuiltSet<ArticleActionType> get values => _$values;

  static ArticleActionType valueOf(String name) => _$valueOf(name);
}
