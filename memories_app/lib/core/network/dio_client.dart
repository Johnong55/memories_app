import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:get/get.dart' hide Response;
import '../config/app_config.dart';
import 'api_interceptors.dart';

class DioClient extends GetxService {
  late Dio _dio;

  String get baseUrl => AppConfig.shared.apiBaseUrl;

  Future<DioClient> init() async {
    final options = BaseOptions(
      baseUrl: AppConfig.shared.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio = Dio(options);

    _dio.interceptors.add(AuthInterceptor());
    
    if (AppConfig.shared.enableLogging) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
      ));
    }

    return this;
  }

  Dio get dio => _dio;
  
  // Helper methods to keep usage clean
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) =>
      _dio.get(path, queryParameters: queryParameters);

  Future<Response> post(String path, {dynamic data}) =>
      _dio.post(path, data: data);
      
  Future<Response> put(String path, {dynamic data}) =>
      _dio.put(path, data: data);

  Future<Response> delete(String path) =>
      _dio.delete(path);
}
