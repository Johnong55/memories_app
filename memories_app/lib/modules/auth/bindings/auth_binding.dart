import 'package:get/get.dart';
// import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/services/auth_service.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/auth_usecases.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // We already have AuthService and DioClient as GetxServices (init in main)
    
    // Repository
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(
      Get.find<DioClient>(),
      Get.find<AuthService>(),
    ));

    // UseCases
    Get.lazyPut(() => LoginUseCase(Get.find<AuthRepository>()));
    Get.lazyPut(() => RegisterUseCase(Get.find<AuthRepository>()));

    // Controller
    Get.lazyPut(() => AuthController(
      Get.find<LoginUseCase>(),
      Get.find<RegisterUseCase>(),
    ));
  }
}
