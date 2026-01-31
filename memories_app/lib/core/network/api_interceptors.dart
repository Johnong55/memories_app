import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final authService = Get.find<AuthService>();
    final token = authService.accessToken;
    
    // Don't attach token for auth endpoints (login/register)
    if (token != null && !options.path.contains('/auth/login') && !options.path.contains('/auth/register')) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final authService = Get.find<AuthService>();
      
      // If we are already refreshing or it was a refresh request that failed
      if (err.requestOptions.path.contains('/auth/refresh')) {
        await authService.logout();
        return handler.next(err);
      }

      final success = await authService.refreshToken();
      if (success) {
        // Retry original request with new token
        final token = authService.accessToken;
        final opts = err.requestOptions;
        opts.headers['Authorization'] = 'Bearer $token';
        
        // We need to create a new request based on the original options
        // But Dio interceptors are tricky for retry.
        // Simplest way is to resolve with a new request
        try {
          final dio = Get.find<Dio>(); // Resolve the main Dio instance
          final response = await dio.fetch(opts);
          return handler.resolve(response);
        } catch (e) {
           return handler.next(err);
        }
      } else {
        await authService.logout();
      }
    }
    handler.next(err);
  }
}
