import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'query_sort_type.g.dart';

    /// 查询排序类型
class QuerySortType extends EnumClass  {


    static Serializer<QuerySortType> get serializer => _$querySortTypeSerializer;

     /// 降序
    static const QuerySortType DESC = _$DESC;
     /// 升序
    static const QuerySortType ASC = _$ASC;

    const QuerySortType._(String name):super(name);

    static BuiltSet<QuerySortType> get values => _$values;

    static QuerySortType valueOf(String name) => _$valueOf(name);
}
