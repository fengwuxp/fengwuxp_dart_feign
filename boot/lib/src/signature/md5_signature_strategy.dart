import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:logging/logging.dart';

const String _APP_ID_KEY = "appId";
const String _APP_SECRET_KEY = "appSecret";
const String _CHANNEL_CODE_KEY = "channelCode";
const String _NONCE_STR_KEY = "nonceStr";
const String _TIME_STAMP_KEY = "timeStamp";
const String _API_SIGNATURE_KEY = "apiSignature";

const String _APP_ID_HEADER_KEY = "Api-App-Id";
const String _NONCE_STR_HEADER_KEY = "Api-Nonce-Str";
const String _APP_SIGN_HEADER_KEY = "Api-Signature";
const String _TIME_STAMP_HEADER_KEY = "Api-Time-Stamp";
const String _CHANNEL_CODE_HEADER_KEY = "Api-Channel-Code";

/// 基于md5的接口签名
class Md5SignatureStrategy extends ApiSignatureStrategy {
  static const String _TAG = "Md5SignatureStrategy";

  static var _log = Logger(_TAG);

  final String appId;

  final String appSecret;

  final String channelCode;

  Md5SignatureStrategy(this.appId, this.appSecret, this.channelCode);

  @override
  void sign(List<String> fields, FeignBaseRequest feignRequest) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final noneStr = "${feignRequest.requestId}_$timestamp";
    final appSignature = this._apiSign(fields, feignRequest, timestamp, noneStr);

    //加入请求头
    feignRequest.headers.addAll({
      _APP_ID_HEADER_KEY: this.appId,
      _NONCE_STR_HEADER_KEY: noneStr,
      _TIME_STAMP_HEADER_KEY: timestamp,
      _APP_SIGN_HEADER_KEY: appSignature,
      _CHANNEL_CODE_HEADER_KEY: channelCode
    });
  }

  /// ap请求时签名
  /// @param fields             需要签名的列
  /// @param feignRequest             请求参数
  /// @param timestamp          请求时间戳
  /// @param noneStr            noneStr
  /// @return {string}          返回内容
  String _apiSign(List<String> fields, FeignBaseRequest feignRequest, String timestamp, String noneStr) {
    List<String> values = [];
    if (fields != null) {
      _log.finer("需要签名的字段 $fields");

      // 优先使用body里面的参数进行提交
      var params = feignRequest.body.isEmpty ? feignRequest.queryParams : feignRequest.body;
      values.addAll(fields.map((item) {
        var param = params[item];
        if (param == null) {
          throw SignatureException(message: "参与签名的参数：$item 未传入或值无效!");
        }
        return "$item=$param";
      }));
    }
    //加入appId 、appSecret 时间戳参与签名
    values.addAll({
      "$_APP_ID_KEY=$appId",
      "$_APP_SECRET_KEY=$appSecret",
      "$_CHANNEL_CODE_KEY=$channelCode",
      "$_NONCE_STR_KEY=$noneStr",
      "$_TIME_STAMP_KEY=$timestamp"
    });
    StringBuffer signText = StringBuffer();
    signText.writeAll(values, "&");
    var sign = signText.toString();
    _log.finer("签名字符串 $sign");
    var content = new Utf8Encoder().convert(sign);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }
}
