import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'article_action_type.g.dart';

    /// 文章互动类型
class ArticleActionType extends EnumClass  {


    static Serializer<ArticleActionType> get serializer => _$articleActionTypeSerializer;

     /// 阅读
    static const ArticleActionType VIEW = _$VIEW;
     /// 点赞
    static const ArticleActionType LIKE = _$LIKE;
     /// 评论
    static const ArticleActionType COMMENT = _$COMMENT;
     /// 收藏
    static const ArticleActionType COLLECTION = _$COLLECTION;
     /// 分享
    static const ArticleActionType SHARE = _$SHARE;

    const ArticleActionType._(String name):super(name);

    static BuiltSet<ArticleActionType> get values => _$values;

    static ArticleActionType valueOf(String name) => _$valueOf(name);
}
