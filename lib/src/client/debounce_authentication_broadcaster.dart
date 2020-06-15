import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/client/authentication_strategy.dart';

class DebounceAuthenticationBroadcaster implements AuthenticationBroadcaster {
  static const String DEBOUNCE_UNAUTHORIZED_TAG = "DebounceAuthenticationBroadcaster#sendUnAuthorizedEvent";
  static const String DEBOUNCE_AUTHORIZED_TAG = "DebounceAuthenticationBroadcaster#sendAuthorizedEvent";
  static const String DEBOUNCE_SIGN_OUT_TAG = "DebounceAuthenticationBroadcaster#sendSignOutEvent";

  AuthenticationBroadcaster _authenticationBroadcaster;

  DebounceAuthenticationBroadcaster(this._authenticationBroadcaster);

  @override
  void sendUnAuthorizedEvent() {
    EasyDebounce.debounce(DEBOUNCE_UNAUTHORIZED_TAG, Duration(milliseconds: 200), () {
      this._authenticationBroadcaster?.sendUnAuthorizedEvent();
    });
  }

  @override
  void sendAuthorizedEvent() {
    EasyDebounce.debounce(DEBOUNCE_AUTHORIZED_TAG, Duration(milliseconds: 200), () {
      this._authenticationBroadcaster?.sendAuthorizedEvent();
    });
  }

  @override
  void sendSignOutEvent() {
    EasyDebounce.debounce(DEBOUNCE_SIGN_OUT_TAG, Duration(milliseconds: 200), () {
      this._authenticationBroadcaster?.sendSignOutEvent();
    });
  }

  @override
  receiveAuthorizedEvent(void Function() handle) {
    this._authenticationBroadcaster?.receiveAuthorizedEvent(handle);
  }

  @override
  receiveUnAuthorizedEvent(void Function() handle) {
    this._authenticationBroadcaster?.receiveUnAuthorizedEvent(handle);
  }

  @override
  receiveSignOutEvent(void Function() handle) {
    this._authenticationBroadcaster?.receiveSignOutEvent(handle);
  }
}
