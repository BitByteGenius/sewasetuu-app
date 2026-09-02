import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/modules/stay/widgets/property_card.dart';

/// Horizontal carousel of similar properties in the same category or location
class SimilarPropertiesWidget extends StatelessWidget {
  final List<PropertyModel> similarStays;
  final ValueChanged<PropertyModel> onStayTap;

  const SimilarPropertiesWidget({
    super.key,
    required this.similarStays,
    required this.onStayTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (similarStays.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Similar Accommodations',
          style: AppTextStyles.headlineSmall(isDark).copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        AppSpacing.gapV4,
        Text(
          'Other verified places you might also like',
          style: AppTextStyles.bodySmall(isDark),
        ),
        AppSpacing.gapV16,

        SizedBox(
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: similarStays.length,
            separatorBuilder: (context, index) => AppSpacing.gapH12,
            itemBuilder: (context, index) {
              final item = similarStays[index];
              return StayCardWidget(
                stay: item,
                style: StayCardStyle.compact,
                width: 240,
                onTap: () => onStayTap(item),
              );
            },
          ),
        ),
      ],
    );
  }
}
