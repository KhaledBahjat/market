import 'package:dio/dio.dart';
import 'package:market/core/networke/dio_clint.dart';

class ApiServices {
  final DioClient dioClient;

  ApiServices(this.dioClient);

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dioClient.get(
      path,
      queryParameters: queryParameters,
    );
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dioClient.post(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dioClient.patch(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dioClient.delete(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }
}
