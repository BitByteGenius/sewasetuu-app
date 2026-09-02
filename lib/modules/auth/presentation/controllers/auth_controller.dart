import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/modules/auth/domain/usecases/login_usecase.dart';

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;

  AuthController({required this.loginUseCase});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  final RxBool isOtpSent = false.obs;
  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    super.onClose();
  }

  Future<void> sendOtp() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      try {
        await loginUseCase.sendOtp(phoneController.text);
        isOtpSent.value = true;
        Get.snackbar(
          'OTP Sent',
          'A 6-digit verification code has been sent to +91 ${phoneController.text}',
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> verifyOtpAndLogin() async {
    if (otpController.text.length < 4) {
      Get.snackbar('Invalid OTP', 'Please enter a valid verification code');
      return;
    }

    isLoading.value = true;
    try {
      await loginUseCase.verifyOtp(phoneController.text, otpController.text);
      Get.offAllNamed(AppRoutes.main);
    } catch (e) {
      Get.snackbar('Verification Failed', 'Invalid code or expired session');
    } finally {
      isLoading.value = false;
    }
  }

  void skipAuth() {
    Get.offAllNamed(AppRoutes.main);
  }
}
