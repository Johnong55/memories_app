import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/usecases/auth_usecases.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  final LoginUseCase _loginUseCase;
  // final RegisterUseCase _registerUseCase;

  AuthController(this._loginUseCase, RegisterUseCase registerUseCase); // keeping dependency but unused for now

  // Login Form
  final loginEmailController = TextEditingController(text: 'user@example.com');
  final loginPasswordController = TextEditingController(text: 'password123');
  final RxBool isLoading = false.obs;
  
  // Register Form
  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();

  Future<void> login() async {
    if (loginEmailController.text.isEmpty || loginPasswordController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter email and password');
      return;
    }

    isLoading.value = true;
    final result = await _loginUseCase(
      email: loginEmailController.text,
      password: loginPasswordController.text,
    );
    isLoading.value = false;

    if (result.data != null) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar('Error', result.error?.message ?? 'Login failed');
    }
  }

  Future<void> register() async {
     // TODO: Implement register logic similar to login
  }

  void goToRegister() {
    Get.toNamed(Routes.REGISTER);
  }
}
