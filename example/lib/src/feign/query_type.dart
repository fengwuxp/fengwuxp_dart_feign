import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'query_type.g.dart';

    /// 查询类型
class QueryType extends EnumClass  {


    static Serializer<QueryType> get serializer => _$queryTypeSerializer;

     /// 查询总数
    static const QueryType QUERY_NUM = _$QUERY_NUM;
     /// 查询结果集
    static const QueryType QUERY_RESET = _$QUERY_RESET;
     /// 查询总数和结果集
    static const QueryType QUERY_BOTH = _$QUERY_BOTH;

    const QueryType._(String name):super(name);

    static BuiltSet<QueryType> get values => _$values;

    static QueryType valueOf(String name) => _$valueOf(name);
}
