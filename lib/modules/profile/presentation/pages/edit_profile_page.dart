import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/modules/profile/presentation/controllers/profile_controller.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';
import 'package:sewasetu/shared/widgets/app_text_field.dart';

/// User profile information edit screen
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ProfileController controller = Get.find<ProfileController>();
  late TextEditingController nameCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController emailCtrl;
  final TextEditingController cityCtrl = TextEditingController(text: 'Guwahati, Assam');

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: controller.userName.value);
    phoneCtrl = TextEditingController(text: controller.userPhone.value);
    emailCtrl = TextEditingController(text: controller.userEmail.value);
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    cityCtrl.dispose();
    super.dispose();
  }

  void saveProfile() {
    controller.userName.value = nameCtrl.text.trim();
    controller.userPhone.value = phoneCtrl.text.trim();
    controller.userEmail.value = emailCtrl.text.trim();
    Get.back();
    Get.snackbar('Profile Updated', 'Your profile details have been saved successfully.', snackPosition: SnackPosition.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: AppTextStyles.headlineSmall(isDark),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          children: [
            AppSpacing.gapV16,
            // Avatar with edit badge
            Center(
              child: Stack(
                children: [
                  const AppNetworkImage(
                    imageUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80',
                    width: 90,
                    height: 90,
                    borderRadius: AppRadius.radiusPill,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        size: 16,
                        color: isDark ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.gapV24,

            AppTextField(
              controller: nameCtrl,
              label: 'Full Name',
              prefixIcon: const Icon(Icons.person_outline_rounded),
            ),
            AppSpacing.gapV16,

            AppTextField(
              controller: phoneCtrl,
              label: 'Phone Number',
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone_iphone_rounded),
            ),
            AppSpacing.gapV16,

            AppTextField(
              controller: emailCtrl,
              label: 'Email Address',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.mail_outline_rounded),
            ),
            AppSpacing.gapV16,

            AppTextField(
              controller: cityCtrl,
              label: 'Home City',
              prefixIcon: const Icon(Icons.location_city_rounded),
            ),
            AppSpacing.gapV32,

            AppButton.primary(
              text: 'Save Changes',
              width: double.infinity,
              onPressed: saveProfile,
            ),
          ],
        ),
      ),
    );
  }
}
