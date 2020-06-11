import 'package:fengwuxp_dart_openfeign/index.dart';

abstract class FileUploadStrategyResult {
  String get url;
}

/// file 上传策略
abstract class FileUploadStrategy {
  /// upload file
  /// param [file] File or String ,is String is file path or base64 data
  /// param [index]
  /// param [request]
  /// return  default file remote url
  Future<FileUploadStrategyResult> upload(dynamic file, num index, FeignRequest request);

  /// 文件上传 {@link FileUploadProgressBar}
  FileUploadProgressBar get fileUploadProgressBar;
}
