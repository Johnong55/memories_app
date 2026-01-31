import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'storage_service.dart';
import '../constants/api_endpoints.dart';
import '../network/dio_client.dart'; // Circular dependency risk? No, DioClient will use AuthService, but AuthService shouldn't use DioClient directly for refresh if possible to avoid loop.

class AuthService extends GetxService {
  final StorageService _storageService = Get.find<StorageService>();
  final RxBool isLoggedIn = false.obs;

  Future<AuthService> init() async {
    isLoggedIn.value = _storageService.hasToken;
    return this;
  }

  String? get accessToken => _storageService.getAccessToken();
  String? get refreshTokenStr => _storageService.getRefreshToken();

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storageService.write(StorageKeys.token, accessToken);
    await _storageService.write(StorageKeys.refreshToken, refreshToken);
    isLoggedIn.value = true;
  }

  Future<void> logout() async {
    await _storageService.remove(StorageKeys.token);
    await _storageService.remove(StorageKeys.refreshToken);
    await _storageService.remove(StorageKeys.user);
    isLoggedIn.value = false;
    Get.offAllNamed('/login'); // We will define routes later
  }

  Future<bool> refreshToken() async {
    try {
      final token = refreshTokenStr;
      if (token == null) return false;

      // Create a fresh Dio instance to avoid interceptor loop
      final dio = Dio(BaseOptions(baseUrl: Get.find<DioClient>().baseUrl)); 
      
      final response = await dio.post(ApiEndpoints.refresh, data: {
        'refreshToken': token,
      });

      if (response.statusCode == 200) {
        final data = response.data['data'];
        await saveTokens(data['token'], data['refreshToken']);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
