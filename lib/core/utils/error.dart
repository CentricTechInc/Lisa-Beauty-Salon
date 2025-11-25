import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorUtils {
  static String getFriendlyErrorMessage(dynamic error) {
    if (error is String) {
      log(error);
      // Already a friendly message
      if (!error.contains('Exception') && !error.contains('Error')) {
        return error;
      }
    }

    final errorString = error.toString().toLowerCase();

    if (errorString.contains('network') ||
        errorString.contains('socket') ||
        errorString.contains('internet')) {
      return 'Please check your internet connection and try again.';
    } else if (errorString.contains('auth') ||
        errorString.contains('login') ||
        errorString.contains('password') ||
        errorString.contains('registered')) {
      if (errorString.contains('invalid')) {
        return 'Invalid email or password. Please try again.';
      } else if (errorString.contains('email')) {
        return 'Email is already registered. Please use a different email.';
      }
      return 'Authentication failed. Please check your credentials.';
    } else if (errorString.contains('camera') ||
        errorString.contains('permission')) {
      return 'Camera access is required. Please grant camera permissions in app settings.';
    } else if (errorString.contains('timeout')) {
      return 'Request timed out. Please try again.';
    } else if (errorString.contains('storage') ||
        errorString.contains('quota')) {
      return 'Storage limit reached. Please try again later.';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  static void logError(String error, StackTrace stackTrace, {String? feature}) {
    // In production, you might want to send this to a logging service
    ('🚨 ERROR in $feature: $error');
    print('📋 Stack trace: $stackTrace');

    // You can also send to analytics/crash reporting services here
    // await AnalyticsService.trackError(error, stackTrace, feature: feature);
  }

  static void showErrorSnackbar(String error) {
    Get.snackbar(
      'Error',
      getFriendlyErrorMessage(error),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  static void showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}