import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/app/app.dart';
import 'package:lisa_beauty_salon/app/bindings/app_bindings.dart';
import 'package:lisa_beauty_salon/core/services/preload_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Global Bindings
  AppBindings.init();

  // Initialize PreloadService
  await Get.putAsync(() async {
    final service = PreloadService();
    await service.init();
    return service;
  });

  // This is commented out to disable DevicePreview as it is only active for development mode
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MainApp(),
  //   ),
  // );
  runApp(
    MainApp()
  );
}
