import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/shared/widgets/app_badge.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';

/// Verified host profile card with response rate, superhost badge, and contact button.
class HostProfileCardWidget extends StatelessWidget {
  final StayHostEntity host;
  final VoidCallback? onContactTap;

  const HostProfileCardWidget({
    super.key,
    required this.host,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      padding: AppSpacing.edgeInsetsLg,
      child: Row(
        children: [
          // Avatar
          Stack(
            children: [
              AppNetworkImage(
                imageUrl: host.avatarUrl,
                width: 56,
                height: 56,
                borderRadius: AppRadius.radiusPill,
              ),
              if (host.isSuperHost)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          AppSpacing.gapH16,
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Hosted by ${host.name}',
                        style: AppTextStyles.titleMedium(isDark).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                AppSpacing.gapV4,
                Row(
                  children: [
                    if (host.isSuperHost) ...[
                      const AppBadge(
                        text: 'Superhost',
                        backgroundColor: AppColors.primaryContainer,
                        textColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: Text(
                        '${host.responseRate} response rate',
                        style: AppTextStyles.bodySmall(isDark),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Contact icon button
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              minimumSize: const Size(0, 36),
            ),
            onPressed: onContactTap ?? () {},
            child: const Text('Contact'),
          ),
        ],
      ),
    );
  }
}
