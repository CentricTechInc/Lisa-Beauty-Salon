import 'package:get/get.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/controllers/setting_controller.dart';

class CustomerShellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
  }
}
