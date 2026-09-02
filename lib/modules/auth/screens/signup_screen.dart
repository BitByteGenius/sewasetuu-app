import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/utils/validators.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';
import 'package:sewasetu/shared/widgets/app_text_field.dart';
import '../controllers/auth_controller.dart';

/// Full user registration page
class SignUpPage extends GetView<AuthController> {
  const SignUpPage({super.key});

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
            key: controller.signupFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account',
                  style: AppTextStyles.displaySmall(isDark).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                AppSpacing.gapV8,
                Text(
                  'Join SewaSetu to discover and book verified stays and homestays effortlessly.',
                  style: AppTextStyles.bodyMedium(isDark).copyWith(
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  ),
                ),
                AppSpacing.gapV24,

                // Full Name
                AppTextField(
                  controller: controller.nameController,
                  label: 'Full Name',
                  hint: 'e.g. Rahul Sharma',
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  validator: (v) => AppValidators.required(v, fieldName: 'Full name'),
                ),
                AppSpacing.gapV16,

                // Mobile Number
                AppTextField(
                  controller: controller.phoneController,
                  label: 'Phone Number',
                  hint: '10-digit mobile number',
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone_iphone_rounded),
                  validator: AppValidators.phone,
                ),
                AppSpacing.gapV16,

                // Email (Optional)
                AppTextField(
                  controller: controller.emailController,
                  label: 'Email Address',
                  hint: 'name@example.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.mail_outline_rounded),
                  validator: (v) => v != null && v.isNotEmpty ? AppValidators.email(v) : null,
                ),
                AppSpacing.gapV16,

                // Password
                Obx(() {
                  return AppTextField(
                    controller: controller.passwordController,
                    label: 'Password',
                    hint: 'At least 8 characters',
                    obscureText: !controller.isPasswordVisible.value,
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    validator: AppValidators.password,
                  );
                }),
                AppSpacing.gapV16,

                // Terms & Conditions Checkbox
                Obx(() {
                  return Row(
                    children: [
                      Checkbox(
                        value: controller.agreeToTerms.value,
                        activeColor: isDark ? AppColors.primaryLight : AppColors.primary,
                        onChanged: (val) => controller.agreeToTerms.value = val ?? false,
                      ),
                      Expanded(
                        child: Text(
                          'I agree to SewaSetu Terms of Service & Privacy Policy',
                          style: AppTextStyles.bodySmall(isDark),
                        ),
                      ),
                    ],
                  );
                }),
                AppSpacing.gapV24,

                // Register Button
                Obx(() {
                  return AppButton.primary(
                    text: 'Sign Up & Verify Phone',
                    width: double.infinity,
                    isLoading: controller.isLoading.value,
                    onPressed: controller.signUp,
                  );
                }),
                AppSpacing.gapV24,

                // Already have account
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: AppTextStyles.bodyMedium(isDark),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Text(
                          'Log In',
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
}

typedef SignUpScreen = SignUpPage;
typedef SignupScreen = SignUpPage;
