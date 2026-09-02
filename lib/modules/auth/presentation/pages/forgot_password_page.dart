import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';
import 'package:sewasetu/shared/widgets/app_text_field.dart';

/// Password recovery screen
class ForgotPasswordPage extends GetView<AuthController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Form(
            key: controller.forgotPassFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.gapV16,
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.primaryContainerDark : AppColors.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.lock_reset_rounded,
                      size: 32,
                      color: isDark ? AppColors.primaryLight : AppColors.primary,
                    ),
                  ),
                ),
                AppSpacing.gapV24,
                Text(
                  'Forgot Password?',
                  style: AppTextStyles.displaySmall(isDark).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                AppSpacing.gapV8,
                Text(
                  'Enter your registered email address or mobile number. We will send you instructions to reset your password.',
                  style: AppTextStyles.bodyMedium(isDark).copyWith(
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  ),
                ),
                AppSpacing.gapV32,

                // Input Field
                AppTextField(
                  controller: controller.forgotEmailPhoneController,
                  label: 'Email or Mobile Number',
                  hint: 'name@example.com or 10-digit phone',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.account_circle_outlined),
                ),
                AppSpacing.gapV24,

                // Send Reset Link Button
                Obx(() {
                  return AppButton.primary(
                    text: 'Send Reset Instructions',
                    width: double.infinity,
                    isLoading: controller.isLoading.value,
                    onPressed: controller.requestPasswordReset,
                  );
                }),
                AppSpacing.gapV24,

                Center(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Back to Log In',
                      style: AppTextStyles.labelMedium(isDark).copyWith(
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
