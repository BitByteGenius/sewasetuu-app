import 'dart:async';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/core/constants/app_constants.dart';
import 'package:sewasetu/core/storage/storage_service.dart';

/// Controller handling splash route determination and navigation.
class SplashController extends GetxController {
  final IStorageService _storageService;
  bool _hasNavigated = false;
  Timer? _fallbackTimer;

  SplashController(this._storageService);

  @override
  void onInit() {
    super.onInit();
    _storageService.init();
  }

  @override
  void onReady() {
    super.onReady();
    // Fallback timer ensures navigation even in headless tests or if animation ticker is paused
    _fallbackTimer = Timer(const Duration(milliseconds: 2400), () {
      navigateToNext();
    });
  }

  @override
  void onClose() {
    _fallbackTimer?.cancel();
    _fallbackTimer = null;
    super.onClose();
  }

  /// Navigates to the initial screen based on stored user state.
  /// Preserves the core routing logic:
  /// - First-time user -> Onboarding
  /// - Existing user -> Main marketplace shell
  void navigateToNext() {
    if (_hasNavigated) return;
    _hasNavigated = true;
    _fallbackTimer?.cancel();
    _fallbackTimer = null;

    final hasSeenOnboarding = _storageService.getBool(AppConstants.hasSeenOnboardingKey) ??
        !(_storageService.getBool(AppConstants.isFirstTimeKey) ?? true);

    if (hasSeenOnboarding) {
      final isAuthenticated = _storageService.getBool('is_authenticated') ?? false;
      final token = _storageService.getString(AppConstants.tokenKey);
      if (isAuthenticated || (token != null && token.isNotEmpty)) {
        Get.offAllNamed(AppRoutes.main);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } else {
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }
}
