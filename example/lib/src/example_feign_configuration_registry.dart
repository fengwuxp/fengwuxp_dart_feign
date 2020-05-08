import 'package:bot_toast/bot_toast.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_openfeign_boot/index.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_openfeign_example/src/api_resp.dart';
import 'package:fengwuxp_openfeign_example/src/feign/serializers.dart';
import 'package:bot_toast/src/toast_widget/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ExampleFeignConfigurationRegistry extends FeignConfigurationRegistry {
  @override
  BuiltJsonSerializers get builtJsonSerializers => BuiltJsonSerializers(serializers);

  @override
  void registryMessageConverters(List<HttpMessageConverter> registry) {}

  @override
  void registryClientHttpRequestInterceptors(ClientHttpInterceptorRegistry registry) {
//    registry.addInterceptor(NetworkClientHttpRequestInterceptor(networkFailBack: SimpleNoneNetworkFailBack()));
    registry.addInterceptor(RoutingClientHttpRequestInterceptor("http://localhost:8090/api/"));
  }

  @override
  void registryFeignClientExecutorInterceptors(FeignClientInterceptorRegistry registry) {
    registry.addInterceptor(ProcessBarExecutorInterceptor(ExampleRequestProgressBar()));
    registry.addInterceptor(new UnifiedFailureToastExecutorInterceptor((data, BuiltValueSerializable serializer) {
      var body = data;
      if (data is ResponseEntity) {
        body = data.body;
      }
      if (body == null) {
        return null;
      }
      return ApiResp.formJsonBySerializer(body);
    }));
  }
}

class ExampleRequestProgressBar implements RequestProgressBar {
  CancelFunc _cancelFunc;

  @override
  void showProgressBar([ProgressBarOptions barOptions]) {
    this._cancelFunc = BotToast.showCustomLoading(
      wrapAnimation: loadingAnimation,
      align: Alignment.center,
      crossPage: true,
      clickClose: false,
      allowClick: false,
      backgroundColor: Colors.black26,
      toastBuilder: (_) => const SpinKitCircle(color: Colors.white),
    );
  }

  @override
  void hideProgressBar() {
    if (this._cancelFunc != null) {
      this._cancelFunc();
      this._cancelFunc = null;
    }
  }
}
