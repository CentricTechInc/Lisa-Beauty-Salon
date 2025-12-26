import 'package:get/get.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_loader.dart';

class LoadingService extends GetxService {
  void show() {
    if (Get.isDialogOpen ?? false) return;
    Get.dialog(
      const CommonLoader(),
      barrierDismissible: false,
    );
  }

  void hide() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
