import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/core/constants/app_constants.dart';
import 'package:sewasetu/core/storage/storage_service.dart';

/// Controller for Profile Page managing Dark Mode toggle, stats, and session logout.
class ProfileController extends GetxController {
  final RxBool isDarkMode = false.obs;
  final RxString userName = 'Gulshan Kumar'.obs;
  final RxString userPhone = '+91 98765 43210'.obs;
  final RxString userEmail = 'gulshan@example.com'.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.isRegistered<IStorageService>()) {
      final storage = Get.find<IStorageService>();
      final savedDark = storage.getBool(AppConstants.isDarkModeKey) ?? false;
      isDarkMode.value = savedDark;
    }
  }

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    if (Get.isRegistered<IStorageService>()) {
      final storage = Get.find<IStorageService>();
      storage.setBool(AppConstants.isDarkModeKey, value);
    }
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  void logout() {
    if (Get.isRegistered<IStorageService>()) {
      final storage = Get.find<IStorageService>();
      storage.remove(AppConstants.tokenKey);
      storage.remove(AppConstants.userKey);
    }
    Get.offAllNamed(AppRoutes.login);
  }
}
