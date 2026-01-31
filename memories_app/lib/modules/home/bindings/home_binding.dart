import 'package:get/get.dart';
import '../../moments/controllers/moment_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => MomentCameraController());
  }
}
