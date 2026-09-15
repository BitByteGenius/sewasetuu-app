import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/core/constants/app_constants.dart';
import 'package:sewasetu/core/storage/storage_service.dart';
import 'package:sewasetu/modules/connectivity/connectivity.dart';
import 'bindings/initial_binding.dart';
import 'config/app_config.dart';
import 'routes/app_pages.dart';
import 'theme/app_theme.dart';

/// Root GetMaterialApp configured with themes, routes, and initial bindings.
class SewaSetuApp extends StatelessWidget {
  const SewaSetuApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = Get.isRegistered<IStorageService>() ? Get.find<IStorageService>() : null;
    final isSavedDark = storage?.getBool(AppConstants.isDarkModeKey) ?? false;

    return GetMaterialApp(
      title: AppConfig.instance.appName,
      debugShowCheckedModeBanner: false,
      
      // Theme Configuration (Light by default, or user preference)
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isSavedDark ? ThemeMode.dark : ThemeMode.light,

      // Initial Dependency Injection
      initialBinding: InitialBinding(),

      // Builder hosting the global floating connectivity banner across all routes
      builder: (context, child) {
        return Stack(
          children: [
            if (child != null) child,
            const GlobalConnectivityBanner(),
          ],
        );
      },

      // Routing Configuration
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const Scaffold(
          body: Center(child: Text('Page not found')),
        ),
      ),

      // Default transition animations
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
