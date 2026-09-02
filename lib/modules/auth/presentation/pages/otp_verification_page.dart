import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';

/// Dedicated 6-box OTP entry screen with auto-focus, countdown timer & resend option
class OtpVerificationPage extends GetView<AuthController> {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final String phone = (Get.arguments as String?) ?? controller.phoneController.text;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.gapV16,
              // Verification Icon Emblem
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.primaryContainerDark : AppColors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.mark_email_read_outlined,
                    size: 30,
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                  ),
                ),
              ),
              AppSpacing.gapV24,
              Text(
                'Verify Phone Number',
                style: AppTextStyles.displaySmall(isDark).copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              AppSpacing.gapV8,
              RichText(
                text: TextSpan(
                  style: AppTextStyles.bodyMedium(isDark).copyWith(
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  ),
                  children: [
                    const TextSpan(text: 'We have sent a 6-digit verification code to '),
                    TextSpan(
                      text: '+91 $phone',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.gapV32,

              // 6 OTP Box Inputs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 48,
                    height: 56,
                    child: TextField(
                      controller: controller.otpDigits[index],
                      focusNode: controller.otpFocusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: AppTextStyles.headlineSmall(isDark).copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        filled: true,
                        fillColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                        border: OutlineInputBorder(
                          borderRadius: AppRadius.radiusMd,
                          borderSide: BorderSide(
                            color: isDark ? AppColors.borderDark : AppColors.borderLight,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: AppRadius.radiusMd,
                          borderSide: BorderSide(
                            color: isDark ? AppColors.primaryLight : AppColors.primary,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (index < 5) {
                            controller.otpFocusNodes[index + 1].requestFocus();
                          } else {
                            controller.otpFocusNodes[index].unfocus();
                            controller.verifyOtp(phone);
                          }
                        } else if (value.isEmpty && index > 0) {
                          controller.otpFocusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              AppSpacing.gapV32,

              // Verify Action Button
              Obx(() {
                return AppButton.primary(
                  text: 'Verify & Continue',
                  width: double.infinity,
                  isLoading: controller.isLoading.value,
                  onPressed: () => controller.verifyOtp(phone),
                );
              }),
              AppSpacing.gapV24,

              // Resend Timer & Action
              Center(
                child: Obx(() {
                  if (controller.canResendOtp.value) {
                    return TextButton(
                      onPressed: () => controller.resendOtp(phone),
                      child: Text(
                        'Didn’t receive code? Resend OTP',
                        style: AppTextStyles.labelMedium(isDark).copyWith(
                          color: isDark ? AppColors.primaryLight : AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }
                  return Text(
                    'Resend code in ${controller.resendCountdown.value}s',
                    style: AppTextStyles.bodySmall(isDark).copyWith(
                      color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
