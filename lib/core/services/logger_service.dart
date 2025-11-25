import 'dart:developer';
import 'dart:ui';

import 'package:lisa_beauty_salon/core/themes/theme.dart';


class LoggerService {
  static void info(String message, {String? tag}) {
    _log(message, tag: tag, color: AppColors.success, level: 'INFO');
  }

  static void warn(String message, {String? tag}) {
    _log(message, tag: tag, color: AppColors.warning, level: 'WARN');
  }

  static void error(String message, {String? tag}) {
    _log(message, tag: tag, color: AppColors.error, level: 'ERROR');
  }

  static void debug(String message, {String? tag}) {
    _log(message, tag: tag, color: AppColors.accent, level: 'DEBUG');
  }

  static void _log(
      String message, {
        String? tag,
        required Color color,
        required String level,
      }) {
    final timestamp = DateTime.now();

    // print(logMessage);
    log(
        message,
        name: tag ?? level,
        time: timestamp
    );
  }
}
