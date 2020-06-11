import 'dart:collection';
import 'dart:io';

import 'package:fengwuxp_dart_openfeign/index.dart';

import 'file_upload_strategy.dart';

/// handle file upload
/// example upload file to cloud platform oss
class UploadClientExecutorInterceptor implements FeignClientExecutorInterceptor<FeignRequest> {
  FileUploadStrategy _fileUploadStrategy;

  // parallel upload file
  bool _parallel = true;

  UploadClientExecutorInterceptor(this._fileUploadStrategy, [bool parallel]) : this._parallel = parallel;

  @override
  Future<FeignRequest> preHandle(FeignRequest request, UIOptions uiOptions) async {
    final files = new HashMap.from(request.files);
    // 查找请求体中是否有文件
    request.body.forEach((key, value) {
      if (value is Iterable) {
        if (_isFile(value.first)) {
          files[key] = value;
        }
      } else if (_isFile(value)) {
        files[key] = value;
      }
    });

    if (files.isEmpty) {
      return request;
    }

    var parallel = this._parallel;

    if (parallel) {
      List<Future<FileUploadStrategyResult>> uploadQueue = [];
      List<String> names = [];
      // 上传文件
      var index = 0;
      files.forEach((key, value) {
        names.add(key);
        uploadQueue.add(_uploadFile(value, index, request));
        index++;
      });
      final results = await Future.wait(uploadQueue);
      Map<String, dynamic> map = HashMap.fromIterables(names, results);
      request.body.addAll(map);
    } else {
      int index = 0;
      Map<String, String> map = HashMap();
      for (var entry in files.entries) {
        final value = entry.value;
        final key = entry.key;
        final result = await _uploadFile(value, index, request);
        map[key] = result;
        index++;
      }
    }
    // 清空请求对象中的文件
    request.files.clear();
    return request;
  }

  @override
  Future postError<E>(FeignRequest request, UIOptions uiOptions, error, {BuiltValueSerializable serializer}) async {
    return error;
  }

  @override
  Future postHandle<E>(FeignRequest request, UIOptions uiOptions, E response,
      {BuiltValueSerializable serializer}) async {
    return response;
  }

  _uploadFile(files, num index, FeignRequest request) async {
    var fileUploadStrategy = this._fileUploadStrategy;
    if (files is Iterable) {
      num i = 0;
      return Future.wait(files.map((e) => fileUploadStrategy.upload(files, i++, request).then((value) => value.url)));
    }
    return fileUploadStrategy.upload(files, index, request).then((value) => value.url);
  }

  _isFile(val) {
    if (val == null) {
      return false;
    }
    if (val is File) {
      return true;
    }
    return false;
  }
}
