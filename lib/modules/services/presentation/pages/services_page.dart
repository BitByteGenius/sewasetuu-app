import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/enums/service_type.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';

/// Secondary Module: On-Demand Local Services (Electrician, Plumber, Driver, Cleaning).
class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final services = [
      ServiceType.electrician,
      ServiceType.plumber,
      ServiceType.driver,
      ServiceType.cleaning,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Local Home Services',
          style: AppTextStyles.headlineSmall(isDark),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verified Local Experts',
              style: AppTextStyles.displaySmall(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            AppSpacing.gapV8,
            Text(
              'Book skilled and background-verified service professionals in your city with upfront pricing.',
              style: AppTextStyles.bodyMedium(isDark),
            ),
            AppSpacing.gapV24,
            ...services.map((service) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: AppCard(
                  padding: AppSpacing.edgeInsetsLg,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Text(service.emoji, style: const TextStyle(fontSize: 24)),
                      ),
                      AppSpacing.gapH16,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.label,
                              style: AppTextStyles.titleMedium(isDark).copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            AppSpacing.gapV4,
                            Text(
                              service.description,
                              style: AppTextStyles.bodySmall(isDark),
                            ),
                          ],
                        ),
                      ),
                      AppButton.primary(
                        text: 'Book',
                        size: AppButtonSize.small,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Selected ${service.label} service!')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
