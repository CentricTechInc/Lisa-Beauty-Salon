import 'package:get/get.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';

class PreloadService extends GetxService {
  Future<void> init() async {
    // Start heavy background tasks here
    _preloadCountries();
  }

  void _preloadCountries() {
    // We use Get.find because AuthController should already be in memory via AppBindings
    // or we can wait for it if needed. Since it's lazy, calling Get.find will trigger it.
    try {
      final authController = Get.find<AuthController>();
      if (authController.countriesList.isEmpty) {
        authController.loadCountries();
      }
    } catch (e) {
      // AuthController might not be initialized yet if the binding hasn't run
      // but AppBindings is initialBinding in GetMaterialApp, so it should be fine.
    }
  }
}
