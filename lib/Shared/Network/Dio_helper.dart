import 'package:dio/dio.dart';
import 'package:weatherapp/Shared/Local/constants.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: Constants.baseUrl, receiveDataWhenStatusError: true));
  }

  static Future<Response?> getData({required String url}) async {
    return await dio?.get(url);
  }

  static Future<Response?> postData(
      {required String url,
      dynamic query,
      required Map<String, dynamic> data,
      String? token}) async {
    dio?.options.headers = {'Authorization': token};
    return await dio?.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
