### dart_openfeign

- 支持自动序列化和反序列化请求响应对象
- 支持表单、json 的等方式

#### 通过注解标记和动态代理实现的声明式http请求库
- [typescript版本](https://github.com/fengwuxp/fengwuxp-typescript-spring/tree/master/feign)

#### 使用java代码进行生成的例子
- [生成工具](https://github.com/fengwuxp/common-codegen)

##### 使用 built_value 命令生成 sdk 需要的 .g.dart 依赖
- 命令
```
// 生成项目目录下的文件
flutter packages pub run build_runner build --delete-conflicting-outputs

/// 生成测试用例下的文件
flutter packages pub run build_runner build test --delete-conflicting-outputs

```

##### 接入方式

- 依赖 [fengwuxp_openfeign_boot](./build) ，可以参考 [example](./example)
- 初始化 sdk 
```dart
 FeignInitializer.form(new ExampleFeignConfigurationRegistry(), BuiltJsonSerializers(serializers))
      .businessResponseExtractor((responseBody) {
        final resp = jsonDecode(responseBody);
        if (resp["code"] != 0) {
          return Future.error(resp);
        }
        return Future.value(resp);
      })
      .apiSignatureStrategy(md5signatureStrategy)
      .initialize();
```

#### RestTemplate
- [RestTemplate](./lib/src/client/rest_template.dart) 标准的 http 请求 client

#### 拦截器
- [ClientHttpRequestInterceptor](./lib/src/client/client_http_request_interceptor.dart) 在 http 请求之前做拦截
- [FeignClientExecutorInterceptor](./lib/src/executor/feign_client_executor_interceptor.dart) 处理 请求之前、之后、以及异常响应