import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/app.dart';
import 'package:sewasetu/app/config/app_config.dart';
import 'package:sewasetu/app/config/environment.dart';
import 'package:sewasetu/core/constants/api_constants.dart';
import 'package:sewasetu/core/constants/app_constants.dart';
import 'package:sewasetu/core/storage/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock status bar & orientation styling
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize App Configuration Environment
  AppConfig.initialize(
    appName: AppConstants.appName,
    apiBaseUrl: ApiConstants.baseUrl,
    environment: Environment.dev,
    enableLogging: true,
  );

  // Initialize local persistent storage
  final storageService = StorageService();
  await storageService.init();
  Get.put<IStorageService>(storageService, permanent: true);

  runApp(const SewaSetuApp());
}
