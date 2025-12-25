import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/networks/api_service.dart';
import 'package:lisa_beauty_salon/features/auth/data/data_sources/auth_data_source.dart';
import 'package:lisa_beauty_salon/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:lisa_beauty_salon/features/auth/domain/repositories/auth_repository.dart';
import 'package:lisa_beauty_salon/features/auth/domain/use_cases/auth_use_case.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';

class AppBindings extends Bindings {

  static void init() {
    Get.lazyPut<APIService>(() => APIService(), fenix: true);

    Get.lazyPut<AuthDataSource>(
      () => AuthDataSourceImpl(),
      fenix: true,
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(Get.find<AuthDataSource>()),
      fenix: true,
    );
    Get.lazyPut<AuthUseCase>(
      () => AuthUseCase(Get.find<AuthRepository>()),
      fenix: true,
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
      fenix: true,
    );
  }

  @override
  void dependencies() {
    init();
  }
}