import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/utils/formatters.dart';
import 'package:sewasetu/modules/stay/models/property_details_model.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';

/// Multi-room configuration picker with pricing and amenity highlights
class RoomOptionsSelectorWidget extends StatelessWidget {
  final List<RoomOptionItem> rooms;
  final String selectedRoomId;
  final ValueChanged<RoomOptionItem> onRoomSelected;
  final StayType? stayType;

  const RoomOptionsSelectorWidget({
    super.key,
    required this.rooms,
    required this.selectedRoomId,
    required this.onRoomSelected,
    this.stayType,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isRoomOrFlat = stayType == StayType.room;

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
                  ? (isDark
                      ? AppColors.primaryContainerDark.withAlpha(50)
                      : AppColors.primaryContainer.withAlpha(60))
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
                        isSelected
                            ? Icons.radio_button_checked_rounded
                            : Icons.radio_button_off_rounded,
                        color: isSelected
                            ? (isDark
                                ? AppColors.primaryLight
                                : AppColors.primary)
                            : (isDark
                                ? AppColors.textMutedDark
                                : AppColors.textMutedLight),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.surfaceVariantDark
                              : AppColors.surfaceVariantLight,
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
                  AppSpacing.gapV12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Nightly Price Tag (Only shown if NOT Room / Flat category)
                      if (!isRoomOrFlat) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nightly Rate',
                              style: AppTextStyles.labelSmall(isDark).copyWith(
                                color: isDark
                                    ? AppColors.textMutedDark
                                    : AppColors.textMutedLight,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${AppFormatters.formatCurrency(room.pricePerNight)} / night',
                              style: AppTextStyles.priceTag(isDark, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                      // Monthly Price Tag Badge (Primary for Room/Flat)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (isDark
                                  ? AppColors.primaryLight.withAlpha(25)
                                  : AppColors.primary.withAlpha(15))
                              : (isDark
                                  ? AppColors.surfaceVariantDark
                                  : AppColors.surfaceVariantLight),
                          borderRadius: AppRadius.radiusMd,
                          border: Border.all(
                            color: (isDark
                                    ? AppColors.primaryLight
                                    : AppColors.primary)
                                .withAlpha(60),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: isRoomOrFlat
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.calendar_month_rounded,
                                  size: 13,
                                  color: isDark
                                      ? AppColors.primaryLight
                                      : AppColors.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Monthly Rate',
                                  style: AppTextStyles.labelSmall(isDark).copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                    color: isDark
                                        ? AppColors.primaryLight
                                        : AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${AppFormatters.formatCurrency(room.displayPricePerMonth)} / mo',
                              style: AppTextStyles.priceTag(isDark, fontSize: isRoomOrFlat ? 16 : 14).copyWith(
                                fontWeight: FontWeight.w800,
                                color: isDark
                                    ? AppColors.primaryLight
                                    : AppColors.primary,
                              ),
                            ),
                          ],
                        ),
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
