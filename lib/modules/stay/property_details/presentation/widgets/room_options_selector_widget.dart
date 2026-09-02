import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/utils/formatters.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';

class RoomOptionItem {
  final String id;
  final String title;
  final String bedType;
  final String maxGuests;
  final double pricePerNight;
  final List<String> highlights;

  const RoomOptionItem({
    required this.id,
    required this.title,
    required this.bedType,
    required this.maxGuests,
    required this.pricePerNight,
    required this.highlights,
  });
}

/// Multi-room configuration picker with pricing and amenity highlights
class RoomOptionsSelectorWidget extends StatelessWidget {
  final List<RoomOptionItem> rooms;
  final String selectedRoomId;
  final ValueChanged<RoomOptionItem> onRoomSelected;

  const RoomOptionsSelectorWidget({
    super.key,
    required this.rooms,
    required this.selectedRoomId,
    required this.onRoomSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Room Configuration',
          style: AppTextStyles.headlineSmall(isDark).copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        AppSpacing.gapV4,
        Text(
          'Choose the accommodation unit best suited for your stay',
          style: AppTextStyles.bodySmall(isDark),
        ),
        AppSpacing.gapV16,

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: rooms.length,
          separatorBuilder: (context, index) => AppSpacing.gapV12,
          itemBuilder: (context, index) {
            final room = rooms[index];
            final isSelected = room.id == selectedRoomId;

            return AppCard(
              padding: AppSpacing.edgeInsetsMd,
              onTap: () => onRoomSelected(room),
              borderColor: isSelected
                  ? (isDark ? AppColors.primaryLight : AppColors.primary)
                  : (isDark ? AppColors.borderDark : AppColors.borderLight),
              borderWidth: isSelected ? 2 : 1,
              backgroundColor: isSelected
                  ? (isDark ? AppColors.primaryContainerDark.withAlpha(50) : AppColors.primaryContainer.withAlpha(60))
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          room.title,
                          style: AppTextStyles.titleMedium(isDark).copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Icon(
                        isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                        color: isSelected
                            ? (isDark ? AppColors.primaryLight : AppColors.primary)
                            : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
                      ),
                    ],
                  ),
                  AppSpacing.gapV4,
                  Text(
                    '${room.bedType} • Max ${room.maxGuests}',
                    style: AppTextStyles.bodySmall(isDark),
                  ),
                  AppSpacing.gapV12,
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: room.highlights.map((h) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                          borderRadius: AppRadius.radiusSm,
                        ),
                        child: Text(
                          '✓ $h',
                          style: AppTextStyles.labelSmall(isDark).copyWith(
                            fontSize: 11,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  AppSpacing.gapV12,
                  const Divider(height: 1),
                  AppSpacing.gapV8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Base price',
                        style: AppTextStyles.labelSmall(isDark),
                      ),
                      Text(
                        '${AppFormatters.formatCurrency(room.pricePerNight)} / night',
                        style: AppTextStyles.priceTag(isDark, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
