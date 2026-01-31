import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/config/app_config.dart';
import 'core/config/environment.dart';
import 'core/services/storage_service.dart';
import 'core/services/auth_service.dart';
import 'core/services/location_service.dart';
import 'core/network/dio_client.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Init Config
  AppConfig.init(Environment.dev);
  
  // 2. Init Storage
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  
  // 3. Init Auth Service (depends on Storage)
  await Get.putAsync(() => AuthService().init());
  
  // 4. Init Dio Client (depends on Config)
  await Get.putAsync(() => DioClient().init());

  // 5. Init Location Service
  await Get.putAsync(() => LocationService().init());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Moment Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: Routes.LOGIN, // Start with Login for now
      getPages: AppPages.routes,
    );
  }
}

