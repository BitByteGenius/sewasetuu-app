import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/utils/validators.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';
import 'package:sewasetu/shared/widgets/app_text_field.dart';
import '../controllers/auth_controller.dart';

/// Authentication Screen supporting phone OTP verification & password login
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
              'Skip',
              style: AppTextStyles.labelMedium(isDark).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.gapV16,
                // Logo Emblem
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.primaryContainerDark : AppColors.primaryContainer,
                    borderRadius: AppRadius.radiusLg,
                  ),
                  child: const Center(
                    child: Text('🏡', style: TextStyle(fontSize: 26)),
                  ),
                ),
                AppSpacing.gapV24,
                Text(
                  'Welcome to SewaSetu',
                  style: AppTextStyles.displaySmall(isDark).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                AppSpacing.gapV8,
                Text(
                  'Your trusted marketplace for verified Rooms, PGs, Mess, Homestays & Hotels.',
                  style: AppTextStyles.bodyMedium(isDark).copyWith(
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  ),
                ),
                AppSpacing.gapV32,

                // Phone Input Field
                AppTextField(
                  controller: controller.phoneController,
                  label: 'Phone Number',
                  hint: 'Enter your 10-digit mobile number',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '🇮🇳 +91',
                          style: AppTextStyles.titleMedium(isDark).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 1,
                          height: 20,
                          color: isDark ? AppColors.borderDark : AppColors.borderLight,
                        ),
                      ],
                    ),
                  ),
                  validator: AppValidators.phone,
                ),
                AppSpacing.gapV16,

                // Forgot Password link
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyles.labelMedium(isDark).copyWith(
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                AppSpacing.gapV24,

                // Continue / Send OTP Action
                Obx(() {
                  return AppButton.primary(
                    text: 'Continue with OTP',
                    width: double.infinity,
                    isLoading: controller.isLoading.value,
                    onPressed: () {
                      if (controller.loginFormKey.currentState?.validate() ?? false) {
                        controller.sendOtp();
                      }
                    },
                  );
                }),
                AppSpacing.gapV24,

                // Divider Or
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or connect with',
                        style: AppTextStyles.bodySmall(isDark),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                AppSpacing.gapV24,

                // Social Sign-in Buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildSocialButton(
                        isDark: isDark,
                        label: 'Google',
                        icon: Icons.g_mobiledata_rounded,
                        onTap: () => controller.skipAuth(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildSocialButton(
                        isDark: isDark,
                        label: 'Apple',
                        icon: Icons.apple_rounded,
                        onTap: () => controller.skipAuth(),
                      ),
                    ),
                  ],
                ),
                AppSpacing.gapV32,

                // Sign Up Navigation
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account? ',
                        style: AppTextStyles.bodyMedium(isDark),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.signUp),
                        child: Text(
                          'Sign Up',
                          style: AppTextStyles.bodyMedium(isDark).copyWith(
                            color: isDark ? AppColors.primaryLight : AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.gapV16,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required bool isDark,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.radiusMd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: AppRadius.radiusMd,
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.labelMedium(isDark).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

typedef LoginScreen = LoginPage;
