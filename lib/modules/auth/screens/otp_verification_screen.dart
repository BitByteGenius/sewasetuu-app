import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';
import '../controllers/auth_controller.dart';

/// 6-digit OTP verification screen with auto-focus, countdown timer & resend button
class OtpVerificationPage extends GetView<AuthController> {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final phone = Get.arguments as String? ?? 'your phone';

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
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.primaryContainerDark : AppColors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.mark_email_read_outlined,
                    size: 28,
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
                    const TextSpan(text: 'We sent a 6-digit verification code to '),
                    TextSpan(
                      text: '+91 $phone',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                    ),
                    const TextSpan(text: '. Enter the code below to proceed.'),
                  ],
                ),
              ),
              AppSpacing.gapV32,

              // 6 OTP Digit Input Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 46,
                    height: 56,
                    child: TextField(
                      controller: controller.otpDigits[index],
                      focusNode: controller.otpFocusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: AppTextStyles.headlineSmall(isDark).copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
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
                      onChanged: (val) {
                        if (val.isNotEmpty && index < 5) {
                          controller.otpFocusNodes[index + 1].requestFocus();
                        } else if (val.isEmpty && index > 0) {
                          controller.otpFocusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              AppSpacing.gapV24,

              // Countdown / Resend Option
              Center(
                child: Obx(() {
                  if (controller.canResendOtp.value) {
                    return TextButton.icon(
                      icon: const Icon(Icons.refresh_rounded, size: 18),
                      label: const Text('Resend Code'),
                      onPressed: () => controller.resendOtp(phone),
                    );
                  }
                  return Text(
                    'Resend code in 00:${controller.resendCountdown.value.toString().padLeft(2, '0')}',
                    style: AppTextStyles.bodySmall(isDark),
                  );
                }),
              ),
              AppSpacing.gapV24,

              // Verify Button
              Obx(() {
                return AppButton.primary(
                  text: 'Verify & Continue',
                  width: double.infinity,
                  isLoading: controller.isLoading.value,
                  onPressed: () => controller.verifyOtp(phone),
                );
              }),
              AppSpacing.gapV16,
            ],
          ),
        ),
      ),
    );
  }
}

typedef OtpVerificationScreen = OtpVerificationPage;
