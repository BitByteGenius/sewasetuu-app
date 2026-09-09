import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/widgets/ios_shimmering_loader.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_top_curved_header.dart';

/// Redesigned OTP Verification Screen with matching top curved gradient header,
/// body extending behind the AppBar, 6-digit PIN boxes, and shimmering iOS-type loader.
class OtpVerificationPage extends GetView<AuthController> {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final phone = Get.arguments as String? ?? controller.phoneController.text.trim();

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Matching Top Curved Header Container
            AuthTopCurvedHeader(
              tagText: 'Security Verification',
              tagIcon: Icons.shield_outlined,
              title: 'Verify Code',
              subtitle: 'We sent a 6-digit OTP code to +91 $phone',
            ),

            // 2. OTP Input Fields and Actions
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Instruction Label
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter 6-Digit OTP',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // 6 OTP Digit Input Boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 48,
                        height: 58,
                        child: TextFormField(
                          controller: controller.otpDigits[index],
                          focusNode: controller.otpFocusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(1),
                          ],
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            fillColor: isDark ? const Color(0xFF1E293B) : Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                                width: 1.2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: Color(0xFF14B8A6),
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
                            // When all 6 digits are entered, immediately dismiss keyboard and trigger shimmering verify
                            final allEntered = controller.otpDigits.every((c) => c.text.trim().isNotEmpty);
                            if (allEntered) {
                              FocusScope.of(context).unfocus();
                              SystemChannels.textInput.invokeMethod('TextInput.hide');
                              controller.verifyOtp(phone);
                            }
                          },
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 24),

                  // Countdown Timer / Resend Option
                  Obx(() {
                    if (controller.canResendOtp.value) {
                      return TextButton.icon(
                        icon: const Icon(
                          Icons.refresh_rounded,
                          size: 18,
                          color: Color(0xFF14B8A6),
                        ),
                        label: Text(
                          'Resend OTP Code',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF14B8A6),
                          ),
                        ),
                        onPressed: () => controller.resendOtp(phone),
                      );
                    }
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF334155).withOpacity(0.5)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 14,
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Resend code in 00:${controller.resendCountdown.value.toString().padLeft(2, '0')}',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 28),

                  // Verify & Continue Button with Shimmering iOS-Type Loader
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
                            FocusScope.of(context).unfocus();
                            SystemChannels.textInput.invokeMethod('TextInput.hide');
                            controller.verifyOtp(phone);
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
                                      'Verifying...',
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
                                    'Verify & Continue',
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

                  const SizedBox(height: 28),

                  // Help notice
                  Text(
                    'Didn’t receive the SMS? Check your network connection or tap Resend Code above.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

typedef OtpVerificationScreen = OtpVerificationPage;
