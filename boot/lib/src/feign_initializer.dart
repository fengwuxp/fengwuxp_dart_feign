import 'package:fengwuxp_dart_openfeign/index.dart';

import 'feign_configuration_boot.dart';
import 'feign_configuration_registry.dart';

void feignInitializer(FeignConfigurationRegistry registry,
    {FeignClientExecutorFactory feignClientExecutorFactory,
    String defaultProduce = HttpMediaType.FORM_DATA,
    RestOperations restOperations,
    RequestURLResolver requestURLResolver,
    RequestParamsResolver requestParamsResolver,
    RequestHeaderResolver requestHeaderResolver,
    ApiSignatureStrategy apiSignatureStrategy,
    AuthenticationBroadcaster authenticationBroadcaster}) {

  registryFeignConfiguration(FeignConfigurationBoot(registry,
      feignClientExecutorFactory: feignClientExecutorFactory,
      defaultProduce: defaultProduce,
      restOperations: restOperations,
      requestURLResolver: requestURLResolver,
      requestParamsResolver: requestParamsResolver,
      requestHeaderResolver: requestHeaderResolver,
      apiSignatureStrategy: apiSignatureStrategy,
      authenticationBroadcaster: authenticationBroadcaster));
}
