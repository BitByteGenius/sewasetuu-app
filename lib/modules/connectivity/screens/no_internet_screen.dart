import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/core/services/connectivity_service.dart';

/// Full-screen dedicated "No Internet" screen displayed when connection remains
/// offline for more than 10 seconds. Seamlessly adheres to both Dark and Light modes.
class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  final RxBool _isChecking = false.obs;
  final RxString _errorMessage = ''.obs;

  Future<void> _handleRetry() async {
    if (_isChecking.value) return;
    _isChecking.value = true;
    _errorMessage.value = '';

    final service = Get.isRegistered<ConnectivityService>()
        ? Get.find<ConnectivityService>()
        : null;

    if (service != null) {
      final isOnline = await service.checkConnection();
      _isChecking.value = false;

      if (!isOnline) {
        _errorMessage.value = 'Still offline. Please check your WiFi or mobile data.';
      }
      // If isOnline is true, ConnectivityService automatically pops this screen
      // and triggers the "Back Online" floating snackbar.
    } else {
      _isChecking.value = false;
      _errorMessage.value = 'Network service unavailable.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;

    // Outer & inner icon container styling for both themes
    final outerBadgeBg = isDark
        ? const Color(0xFF134E4A).withOpacity(0.40)
        : const Color(0xFFCCFBF1);
    final outerBorderColor = isDark
        ? const Color(0xFF14B8A6).withOpacity(0.35)
        : const Color(0xFF0F766E).withOpacity(0.25);
    final innerBadgeBg = isDark ? const Color(0xFF1E293B) : Colors.white;
    final iconColor = isDark ? AppColors.primaryLight : AppColors.primary;

    final titleColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final subtitleColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    final errorCardBg = isDark
        ? const Color(0xFF450A0A).withOpacity(0.60)
        : const Color(0xFFFEF2F2);
    final errorBorderColor = isDark
        ? const Color(0xFFEF4444).withOpacity(0.40)
        : const Color(0xFFFCA5A5);
    final errorTextColor = isDark
        ? const Color(0xFFFCA5A5)
        : const Color(0xFFDC2626);

    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              // Top Spacing
              const Spacer(flex: 2),

              // Center Content: Modern offline illustration, title & subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Glowing Circular Offline Icon Badge
                    Container(
                      width: 124,
                      height: 124,
                      decoration: BoxDecoration(
                        color: outerBadgeBg,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: outerBorderColor,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF0F766E).withOpacity(isDark ? 0.25 : 0.12),
                            blurRadius: 32,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 82,
                          height: 82,
                          decoration: BoxDecoration(
                            color: innerBadgeBg,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(isDark ? 0.35 : 0.06),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.wifi_off_rounded,
                              size: 44,
                              color: iconColor,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Title
                    Text(
                      'No Internet Connection',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                        color: titleColor,
                        decoration: TextDecoration.none,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Subtitle
                    Text(
                      'Please check your network settings and try again to continue using SewaSetu.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: subtitleColor,
                        decoration: TextDecoration.none,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Error feedback banner if retry fails
                    Obx(() {
                      if (_errorMessage.value.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                        decoration: BoxDecoration(
                          color: errorCardBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: errorBorderColor,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.error_outline_rounded,
                              size: 16,
                              color: errorTextColor,
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                _errorMessage.value,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: errorTextColor,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const Spacer(flex: 3),

              // Bottom Action Area: "Try Again" Button
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
                child: SizedBox(
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
                          color: const Color(0xFF0F766E).withOpacity(0.35),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _handleRetry,
                        borderRadius: BorderRadius.circular(16),
                        child: Center(
                          child: Obx(() {
                            if (_isChecking.value) {
                              return const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.4,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              );
                            }
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.refresh_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Try Again',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.2,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
