import 'package:dio/dio.dart';
import 'package:market/core/constant.dart';
import 'package:market/core/sensetive_data.dart';

class ApiServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {"apikey": SENSITIVE_DATA["apikey"]},
    ),
  );

  Future<Response> getData(String path) async {
    return await _dio.get(path);
  }

  Future<Response> postData(String path, Map<String, dynamic> data) async {
    return await _dio.post(path, data: data);
  }
}
