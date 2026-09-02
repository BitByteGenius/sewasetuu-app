import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/modules/home/presentation/controllers/home_controller.dart';
import 'package:sewasetu/modules/profile/presentation/controllers/profile_controller.dart';
import 'package:sewasetu/shared/widgets/app_badge.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';

/// Clean Profile & Settings page with Theme toggle (Light/Dark), stats, and quick links
class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile & Settings',
          style: AppTextStyles.headlineSmall(isDark),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          children: [
            // User Card with Edit Action
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.editProfile),
              child: AppCard(
                padding: AppSpacing.edgeInsetsLg,
                child: Row(
                  children: [
                    const AppNetworkImage(
                      imageUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80',
                      width: 64,
                      height: 64,
                      borderRadius: AppRadius.radiusPill,
                    ),
                    AppSpacing.gapH16,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Obx(() {
                                return Flexible(
                                  child: Text(
                                    controller.userName.value,
                                    style: AppTextStyles.titleLarge(isDark).copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }),
                              const SizedBox(width: 6),
                              const AppBadge.verified(),
                            ],
                          ),
                          AppSpacing.gapV4,
                          Obx(() {
                            return Text(
                              controller.userPhone.value,
                              style: AppTextStyles.bodySmall(isDark),
                            );
                          }),
                          Obx(() {
                            return Text(
                              controller.userEmail.value,
                              style: AppTextStyles.bodySmall(isDark).copyWith(
                                color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.edit_outlined,
                      size: 20,
                      color: isDark ? AppColors.primaryLight : AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
            AppSpacing.gapV16,

            // Quick Stats Row
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (Get.isRegistered<HomeController>()) {
                        Get.find<HomeController>().switchNavTab(2);
                      }
                    },
                    child: _buildStatCard(isDark, '3', 'My Bookings', Icons.check_circle_outline_rounded),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (Get.isRegistered<HomeController>()) {
                        Get.find<HomeController>().switchNavTab(3);
                      }
                    },
                    child: _buildStatCard(isDark, '12', 'Wishlist', Icons.favorite_outline_rounded),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.coupons),
                    child: _buildStatCard(isDark, '3', 'Coupons', Icons.local_offer_outlined),
                  ),
                ),
              ],
            ),
            AppSpacing.gapV24,

            // Preferences & Settings List
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  // Personal Information
                  _buildMenuItem(
                    isDark: isDark,
                    icon: Icons.person_outline_rounded,
                    title: 'Personal Information',
                    subtitle: 'Name, phone, email & identity',
                    onTap: () => Get.toNamed(AppRoutes.editProfile),
                  ),
                  const Divider(height: 1),

                  // Dark Mode Switch Tile
                  Obx(() {
                    return SwitchListTile(
                      secondary: Icon(
                        controller.isDarkMode.value
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode_rounded,
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                      ),
                      title: Text(
                        'Dark Theme',
                        style: AppTextStyles.titleMedium(isDark),
                      ),
                      subtitle: Text(
                        controller.isDarkMode.value ? 'Dark mode enabled' : 'Light mode enabled',
                        style: AppTextStyles.bodySmall(isDark),
                      ),
                      value: controller.isDarkMode.value,
                      onChanged: controller.toggleTheme,
                      activeTrackColor: isDark ? AppColors.primaryLight : AppColors.primary,
                    );
                  }),
                  const Divider(height: 1),

                  // Coupons & Offers
                  _buildMenuItem(
                    isDark: isDark,
                    icon: Icons.local_offer_outlined,
                    title: 'Coupons & Promo Codes',
                    subtitle: 'View available discounts & vouchers',
                    onTap: () => Get.toNamed(AppRoutes.coupons),
                  ),
                  const Divider(height: 1),

                  _buildMenuItem(
                    isDark: isDark,
                    icon: Icons.credit_card_outlined,
                    title: 'Payment Methods',
                    subtitle: 'Saved UPI, cards & wallets',
                    onTap: () => Get.toNamed(AppRoutes.payment),
                  ),
                  const Divider(height: 1),

                  _buildMenuItem(
                    isDark: isDark,
                    icon: Icons.notifications_none_rounded,
                    title: 'Notifications',
                    subtitle: 'Manage alert preferences',
                    onTap: () => Get.toNamed(AppRoutes.notifications),
                  ),
                  const Divider(height: 1),

                  _buildMenuItem(
                    isDark: isDark,
                    icon: Icons.security_outlined,
                    title: 'Privacy & Security',
                    subtitle: 'Account protection & permissions',
                    onTap: () {
                      Get.snackbar('Privacy', 'Your account is protected by 256-bit SSL encryption.');
                    },
                  ),
                  const Divider(height: 1),

                  _buildMenuItem(
                    isDark: isDark,
                    icon: Icons.help_outline_rounded,
                    title: 'Help & 24/7 Support',
                    subtitle: 'Customer assistance & FAQs',
                    onTap: () {
                      Get.snackbar('SewaSetu Support', 'Support team is available 24x7 at support@sewasetu.com');
                    },
                  ),
                  const Divider(height: 1),

                  _buildMenuItem(
                    isDark: isDark,
                    icon: Icons.logout_rounded,
                    title: 'Log Out',
                    subtitle: 'Sign out of your account',
                    iconColor: AppColors.error,
                    textColor: AppColors.error,
                    onTap: controller.logout,
                  ),
                ],
              ),
            ),
            AppSpacing.gapV32,
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(bool isDark, String number, String label, IconData icon) {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
            color: isDark ? AppColors.primaryLight : AppColors.primary,
          ),
          AppSpacing.gapV8,
          Text(
            number,
            style: AppTextStyles.titleLarge(isDark).copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: AppTextStyles.bodySmall(isDark).copyWith(
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required bool isDark,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? (isDark ? AppColors.primaryLight : AppColors.primary),
      ),
      title: Text(
        title,
        style: AppTextStyles.titleMedium(isDark).copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodySmall(isDark),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
      onTap: onTap,
    );
  }
}
