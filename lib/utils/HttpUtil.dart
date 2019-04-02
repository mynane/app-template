import 'package:dio/dio.dart';

// or new Dio with a Options instance.
BaseOptions options = new BaseOptions(
    baseUrl: "https://timeline-merger-ms.juejin.im/v1/",
    connectTimeout: 5000,
    receiveTimeout: 3000,
);

Dio dio = new Dio(options);

class HttpUtil {
  static Future get(String url,{Map<String,dynamic> params}) async{
     var response = await dio.get(url, queryParameters: params);
    return  response.data;
  }

  static Future post(String url,Map<String,dynamic> params) async{
    var response = await dio.post(url, data: params);
    return response.data;
  }
}
