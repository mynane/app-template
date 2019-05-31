import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:async';

class DownloadFile {
  load(uri) async {
    final savedDir = Directory('../htmls/');
    // bool hasExisted = await savedDir.exists();
    // if (!hasExisted) {
    //   savedDir.create();
    // }
    final taskId = await FlutterDownloader.enqueue(
      url: uri,
      savedDir: savedDir.path,
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );
    return taskId;
  }
}
