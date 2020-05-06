import 'package:fengwuxp_dart_openfeign/src/client/authentication_strategy.dart';
import 'package:fengwuxp_dart_basic/index.dart';

class DebounceAuthenticationBroadcaster implements AuthenticationBroadcaster {
  static const String DEBOUNCE_TAG = "DebounceAuthenticationBroadcaster#sendUnAuthorizedEvent";

  AuthenticationBroadcaster _authenticationBroadcaster;

  DebounceAuthenticationBroadcaster(this._authenticationBroadcaster);

  @override
  void sendUnAuthorizedEvent() {
    EasyDebounce.debounce(DEBOUNCE_TAG, Duration(milliseconds: 200), () {
      this._authenticationBroadcaster.sendUnAuthorizedEvent();
    });
  }

  @override
  receiveAuthorizedEvent(void Function() handle) {
    this._authenticationBroadcaster.receiveAuthorizedEvent(handle);
  }
}
