import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';

/// Controller for User Authentication (Login, Sign-Up, OTP Verification, Password Recovery)
class AuthController extends GetxController {
  // Keys & Controllers
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgotPassFormKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController forgotEmailPhoneController = TextEditingController();

  // 6 individual OTP digit controllers & focus nodes
  final List<TextEditingController> otpDigits = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> otpFocusNodes = List.generate(6, (_) => FocusNode());

  // Observables
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool agreeToTerms = true.obs;
  final RxInt resendCountdown = 30.obs;
  final RxBool canResendOtp = false.obs;
  Timer? _countdownTimer;

  @override
  void onClose() {
    phoneController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    forgotEmailPhoneController.dispose();
    for (var c in otpDigits) {
      c.dispose();
    }
    for (var f in otpFocusNodes) {
      f.dispose();
    }
    _countdownTimer?.cancel();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void startResendTimer() {
    resendCountdown.value = 30;
    canResendOtp.value = false;
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        canResendOtp.value = true;
        timer.cancel();
      }
    });
  }

  /// Send OTP and navigate to dedicated OTP verification page
  Future<void> sendOtp({String? targetPhone}) async {
    final phone = targetPhone ?? phoneController.text.trim();
    if (phone.isEmpty) {
      Get.snackbar('Error', 'Please enter your mobile number', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      startResendTimer();
      Get.toNamed(AppRoutes.otpVerification, arguments: phone);
    } catch (_) {
      Get.snackbar('Error', 'Failed to send OTP code. Please try again.', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  /// Resend OTP trigger
  Future<void> resendOtp(String phone) async {
    if (!canResendOtp.value) return;
    await sendOtp(targetPhone: phone);
    Get.snackbar('OTP Resent', 'A new 6-digit code has been sent to +91 $phone', snackPosition: SnackPosition.BOTTOM);
  }

  /// Verify entered 6-digit OTP
  Future<void> verifyOtp(String phone) async {
    final enteredOtp = otpDigits.map((c) => c.text).join();
    if (enteredOtp.length < 6) {
      Get.snackbar('Invalid OTP', 'Please enter the complete 6-digit code', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 600));
      Get.offAllNamed(AppRoutes.main);
      Get.snackbar('Welcome to SewaSetu', 'You are now signed in successfully!', snackPosition: SnackPosition.BOTTOM);
    } catch (_) {
      Get.snackbar('Verification Failed', 'Invalid or expired OTP code', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  /// Full account registration
  Future<void> signUp() async {
    if (!(signupFormKey.currentState?.validate() ?? false)) return;
    if (!agreeToTerms.value) {
      Get.snackbar('Terms Required', 'Please accept the Terms of Service to continue');
      return;
    }

    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      sendOtp(targetPhone: phoneController.text.trim());
    } finally {
      isLoading.value = false;
    }
  }

  /// Request password reset
  Future<void> requestPasswordReset() async {
    if (forgotEmailPhoneController.text.trim().isEmpty) {
      Get.snackbar('Required', 'Please enter your registered email or mobile number');
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    isLoading.value = false;
    Get.back();
    Get.snackbar(
      'Reset Link Sent',
      'Password reset instructions have been sent to ${forgotEmailPhoneController.text.trim()}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void skipAuth() {
    Get.offAllNamed(AppRoutes.main);
  }
}
