import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/core/constants/app_constants.dart';
import 'package:sewasetu/core/storage/storage_service.dart';

/// Controller handling splash animation timing and initial route determination.
class SplashController extends GetxController {
  final IStorageService _storageService;

  SplashController(this._storageService);

  @override
  void onReady() {
    super.onReady();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(milliseconds: 2200));

    final isFirstTime = _storageService.getBool(AppConstants.isFirstTimeKey) ?? true;
    final token = _storageService.getString(AppConstants.tokenKey);

    if (isFirstTime) {
      Get.offAllNamed(AppRoutes.onboarding);
    } else if (token != null && token.isNotEmpty) {
      Get.offAllNamed(AppRoutes.main);
    } else {
      Get.offAllNamed(AppRoutes.main); // Direct access to explore marketplace
    }
  }
}
