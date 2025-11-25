import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_saloon/app/bindings/app_bindings.dart';
import 'package:lisa_beauty_saloon/app/router/app_pages.dart';
import 'package:lisa_beauty_saloon/core/constants/app_constants.dart';
import 'package:lisa_beauty_saloon/core/constants/route_constants.dart';
import 'package:lisa_beauty_saloon/core/themes/theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialBinding: AppBindings(),
      initialRoute: RouteNames.splash,
      getPages: AppPages.routes,
      defaultTransition: Transition.cupertino,
      // Enable nested navigation keys
      navigatorKey: Get.key,
      navigatorObservers: [GetObserver()],
    );
  }
}
