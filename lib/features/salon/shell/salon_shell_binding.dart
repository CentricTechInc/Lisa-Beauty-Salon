import 'package:get/get.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/controllers/setting_controller.dart';

class SalonShellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
  }
}
