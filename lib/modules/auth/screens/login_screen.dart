import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/widgets/ios_shimmering_loader.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_top_curved_header.dart';

/// Redesigned Login Screen featuring a top curved gradient header,
/// body extending behind the AppBar, phone input, and a custom shimmering iOS-type loader.
class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: TextButton(
              onPressed: controller.skipAuth,
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                backgroundColor: Colors.white.withValues(alpha: 0.18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.white.withValues(alpha: 0.28),
                    width: 1,
                  ),
                ),
              ),
              child: Text(
                'Skip',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Top Curved Header Container
            const AuthTopCurvedHeader(
              tagText: 'SewaSetu Marketplace',
              tagIcon: Icons.verified_user_rounded,
              title: 'Welcome Back',
              subtitle: 'Enter your mobile number to explore verified stays, treks & rentals.',
            ),

            // 2. Main Body Fields
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
              child: Form(
                key: controller.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Field Label
                    Text(
                      'Mobile Number',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Phone Number Input with +91 Country Code
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(isDark ? 0.20 : 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Country Code Prefix
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('🇮🇳', style: TextStyle(fontSize: 18)),
                                const SizedBox(width: 6),
                                Text(
                                  '+91',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: 1.2,
                                  height: 22,
                                  color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                                ),
                              ],
                            ),
                          ),

                          // Text Input Field
                          Expanded(
                            child: TextFormField(
                              controller: controller.phoneController,
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : const Color(0xFF0F172A),
                                letterSpacing: 1.2,
                              ),
                              decoration: InputDecoration(
                                hintText: '98765 43210',
                                hintStyle: GoogleFonts.plusJakartaSans(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5,
                                  color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                                ),
                                counterText: '',
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Continue Button with Shimmering iOS-Type Loader
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0F766E).withOpacity(0.38),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              final phone = controller.phoneController.text.trim();
                              if (phone.length < 10) {
                                Get.snackbar(
                                  'Invalid Phone',
                                  'Please enter a valid 10-digit mobile number',
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: const EdgeInsets.all(16),
                                  borderRadius: 14,
                                );
                                return;
                              }
                              controller.sendOtp();
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Center(
                              child: Obx(() {
                                if (controller.isLoading.value) {
                                  return const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IosShimmeringLoader(
                                        size: 22,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Sending OTP...',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Continue with OTP',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 15.5,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 19,
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Security Trust & Terms Footnote
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.lock_outline_rounded,
                                  size: 14,
                                  color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '100% Secure & Verified Authentication',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'By continuing, you agree to SewaSetu’s Terms of Service and Privacy Policy.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w400,
                                height: 1.45,
                                color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

typedef LoginScreen = LoginPage;
