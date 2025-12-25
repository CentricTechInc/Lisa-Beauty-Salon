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

  runApp(const MainApp());
}
