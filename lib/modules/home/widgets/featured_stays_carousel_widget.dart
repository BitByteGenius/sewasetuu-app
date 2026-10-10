import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/modules/stay/stay.dart';
import 'package:sewasetu/shared/widgets/app_section_header.dart';

/// Featured Stays Carousel with horizontal scroll and quick explore.
class FeaturedStaysCarouselWidget extends StatelessWidget {
  final List<PropertyModel> stays;
  final ValueChanged<PropertyModel> onStayTap;
  final ValueChanged<PropertyModel>? onFavoriteToggle;
  final VoidCallback onViewAll;

  const FeaturedStaysCarouselWidget({
    super.key,
    required this.stays,
    required this.onStayTap,
    this.onFavoriteToggle,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    if (stays.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(
          title: 'Featured Accommodations',
          subtitle: 'Handpicked verified stays with top ratings',
          onAction: onViewAll,
          padding: AppSpacing.horizontalLg,
        ),
        AppSpacing.gapV12,
        SizedBox(
          height: 225,
          child: ListView.separated(
            padding: AppSpacing.horizontalLg,
            scrollDirection: Axis.horizontal,
            itemCount: stays.length,
            separatorBuilder: (context, index) => AppSpacing.gapH12,
            itemBuilder: (context, index) {
              final stay = stays[index];
              return StayCardWidget(
                stay: stay,
                style: StayCardStyle.compact,
                width: 260,
                onTap: () => onStayTap(stay),
                onFavoriteToggle: onFavoriteToggle != null
                    ? (_) => onFavoriteToggle!(stay)
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }
}
