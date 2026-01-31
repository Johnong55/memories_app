import 'package:get/get.dart';

class HomeController extends GetxController {
  // Logic for handling tabs and initial data loading
  final RxInt currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}
