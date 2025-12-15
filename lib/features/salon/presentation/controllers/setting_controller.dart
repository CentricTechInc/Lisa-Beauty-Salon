import 'package:get/get.dart';

class SettingController extends GetxController {

  final RxInt currentIndex = 0.obs;
  final RxInt previousIndex = 0.obs;


  void changeTab(int index) {
    if (currentIndex.value == index) return;
    previousIndex.value = currentIndex.value;
    currentIndex.value = index;
  }

}