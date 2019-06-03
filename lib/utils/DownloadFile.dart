import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
Dio dio = new Dio();

class DownloadFile {
  Future<File> _getLocalFile() async {
    // get the path to the document directory.
    String dir = (await getApplicationDocumentsDirectory()).path;
    print(dir);
    return new File('$dir/counter.txt');
  }
  load(uri) async {
    try {
      File file = await _getLocalFile();
      // read the variable as a string from the file.
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      print(FileSystemException);
      return 0;
    }
    // final savedDir = Directory('../htmls/');
    // // bool hasExisted = await savedDir.exists();
    // // if (!hasExisted) {
    // //   savedDir.create();
    // // }
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //   File file = new File("$dir/lib/htmls/detail.html");
  //   //如果文件存在，删除
  //   if(!await file.exists()) {
  //     //创建文件
  //     file = await file.create();
  //   }
  //   print(file);
  //  final data = await dio.get(uri);
  //  print(data);
  }
}
