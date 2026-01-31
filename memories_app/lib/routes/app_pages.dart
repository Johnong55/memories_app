import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memories_app/modules/moments/bindings/moment_binding.dart';
import 'package:memories_app/modules/moments/views/camera_screen.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_screen.dart';
import '../modules/auth/views/register_screen.dart';
import '../modules/home/views/home_screen.dart';
import '../modules/home/bindings/home_binding.dart';


part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    // Splash
    GetPage(
      name: Routes.SPLASH,
      page: () => const Scaffold(body: Center(child: CircularProgressIndicator())), // Placeholder
      // binding: SplashBinding(),
    ),
    
    // Auth
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),
    
    // Home
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    
    // Moments
    GetPage(
      name: Routes.CAMERA,
      page: () => const CameraScreen(),
      binding: MomentBinding(),
    ),
  ];
}
