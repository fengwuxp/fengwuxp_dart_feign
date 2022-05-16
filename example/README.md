

#### 使用java代码进行生成的例子
- [生成工具](https://github.com/fengwuxp/common-codegen)

- [初始化配置](./test/feign_clients_test.dart);
```dart
   final configuration = FeignInitializer.form(new ExampleFeignConfigurationRegistry(), BuiltJsonSerializers(serializers))
      .businessResponseExtractor((responseBody) {
        final resp = jsonDecode(responseBody);
        if (resp["code"] != 0) {
          return Future.error(resp);
        }
        return Future.value(resp);
      })
      .apiSignatureStrategy(md5signatureStrategy)
      .initialize();
     
   configuration.httpResponseEventListener.onError((request, entity, options) {
          final Map<String, Object> resp = entity.json();
          // TODO
   });
   
   // 401
   configuration.httpResponseEventListener.onUnAuthorized((request, entity, options) {
     // TODO
   });
```