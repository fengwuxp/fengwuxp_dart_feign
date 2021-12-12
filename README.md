### dart_openfeign
借鉴 spring cloud openfeign 的思路提供的 dart 版本 openfeign

- 支持自动序列化和反序列化请求响应对象
- 支持表单、json 的等方式
- 支持请求响应拦截
- 更多

#### Quick-Start
- [快速开始](./quick_star.md)

#### 通过注解标记和动态代理实现的声明式http请求库
- [typescript版本](https://github.com/fengwuxp/fengwuxp-typescript-spring/tree/master/feign)

#### 使用java代码进行生成的例子
- [生成工具](https://github.com/fengwuxp/common-codegen)

#### 反射和 json 序列化支持
- [reflectable](https://github.com/google/reflectable.dart)
- [built_value](https://github.com/google/built_value.dart)
- [build](https://github.com/dart-lang/build)

#### RestTemplate
- [RestTemplate](./lib/src/client/rest_template.dart) 标准的 http 请求 client

#### 拦截器
- [ClientHttpRequestInterceptor](./lib/src/client/client_http_request_interceptor.dart) 在 http 请求之前做拦截
- [FeignClientExecutorInterceptor](./lib/src/executor/feign_client_executor_interceptor.dart) 处理 请求之前、之后、以及异常响应