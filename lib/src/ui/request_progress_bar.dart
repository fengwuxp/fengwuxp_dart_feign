class ProgressBarOptions {
  /// 是否使用蒙版
  final bool mask;

  /// 提示的延迟时间，
  /// 单位毫秒，默认：300
  final int delay;

  /// 进度条提示标题
  final String title;

  /// 进度条提示图标
  /// 图标，字体图标名称或图片url
  final String icon;

  const ProgressBarOptions({bool mask = false, int delay = 300, String title = "", String icon})
      : this.mask = mask,
        this.delay = delay,
        this.title = title,
        this.icon = icon;
}

/// request process bar
abstract class RequestProgressBar<T extends ProgressBarOptions> {

  // It will not be called until the last 'ProgressBar' is closed,
  void showProgressBar([ProgressBarOptions barOptions]);

  /// [hideProgressBar] will be called more times than [showProgressBar]
  void hideProgressBar();
}

class FileUploadProgressBarOptions extends ProgressBarOptions {}

//  file upload progressbar
abstract class FileUploadProgressBar extends RequestProgressBar<FileUploadProgressBarOptions> {
  /// param [progress]  upload progress
  /// param [fileIndex]
  void onUploadProgressChange(num progress, int fileIndex);
}
