import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../controllers/auth_controller.dart';

/// Clean authentication page with phone login, OTP verification toggle, and social placeholders.
class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: controller.skipAuth,
            child: Text(
              'Explore First',
              style: AppTextStyles.labelMedium(isDark).copyWith(
                color: isDark ? AppColors.primaryLight : AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.gapV24,
                Text(
                  'Welcome to SewaSetu',
                  style: AppTextStyles.displaySmall(isDark).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                AppSpacing.gapV8,
                Text(
                  'Log in or register to book stays, manage rentals, and access local marketplace services.',
                  style: AppTextStyles.bodyMedium(isDark).copyWith(
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  ),
                ),
                AppSpacing.gapV32,

                // Phone Input
                AppTextField(
                  label: 'Phone Number',
                  hint: 'Enter 10-digit mobile number',
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  validator: AppValidators.validatePhone,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    child: Text(
                      '+91',
                      style: AppTextStyles.labelLarge(isDark).copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                // OTP Input (Conditional)
                Obx(() {
                  if (!controller.isOtpSent.value) return const SizedBox.shrink();
                  return Column(
                    children: [
                      AppSpacing.gapV16,
                      AppTextField(
                        label: '6-digit OTP',
                        hint: 'Enter OTP code',
                        controller: controller.otpController,
                        keyboardType: TextInputType.number,
                        prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
                      ),
                    ],
                  );
                }),

                AppSpacing.gapV24,

                // CTA Button
                Obx(() {
                  return AppButton.primary(
                    text: controller.isOtpSent.value ? 'Verify & Continue' : 'Get OTP',
                    width: double.infinity,
                    isLoading: controller.isLoading.value,
                    onPressed: controller.isOtpSent.value
                        ? controller.verifyOtpAndLogin
                        : controller.sendOtp,
                  );
                }),

                AppSpacing.gapV24,
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('OR', style: AppTextStyles.labelSmall(isDark)),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                AppSpacing.gapV24,

                // Social Sign-In Buttons
                AppButton.outline(
                  text: 'Continue with Google',
                  width: double.infinity,
                  prefixIcon: const Icon(Icons.g_mobiledata_rounded, size: 24),
                  onPressed: controller.skipAuth,
                ),
                AppSpacing.gapV12,
                AppButton.outline(
                  text: 'Continue with Apple',
                  width: double.infinity,
                  prefixIcon: const Icon(Icons.apple_rounded, size: 20),
                  onPressed: controller.skipAuth,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
