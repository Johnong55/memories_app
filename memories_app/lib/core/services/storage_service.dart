import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/api_endpoints.dart';

class StorageService extends GetxService {
  late GetStorage _box;

  Future<StorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  // Generic methods
  T? read<T>(String key) => _box.read<T>(key);
  Future<void> write(String key, dynamic value) => _box.write(key, value);
  Future<void> remove(String key) => _box.remove(key);
  Future<void> clear() => _box.erase();

  // Auth helper methods
  String? getAccessToken() => read<String>(StorageKeys.token);
  String? getRefreshToken() => read<String>(StorageKeys.refreshToken);
  
  bool get hasToken => getAccessToken() != null;
}
