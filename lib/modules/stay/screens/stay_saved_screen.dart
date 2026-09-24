import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/modules/stay/controllers/stay_controller.dart';
import 'package:sewasetu/modules/stay/controllers/stay_navigation_controller.dart';
import 'package:sewasetu/modules/stay/widgets/property_card.dart';
import 'package:sewasetu/shared/widgets/app_bar/app_bar.dart';
import 'package:sewasetu/shared/widgets/app_empty_state.dart';

/// Screen displaying favorited/saved stay properties in the Stay bottom navigation
class StaySavedScreen extends StatelessWidget {
  const StaySavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<StayController>()
        ? Get.find<StayController>()
        : Get.put(StayController());

    return Scaffold(
      appBar: const SewaAppBar(
        titleText: 'Saved Stays',
        showBackButton: false,
      ),
      body: Obx(() {
        final favorites = controller.savedStays;

        if (favorites.isEmpty) {
          return AppEmptyState(
            icon: Icons.favorite_border_rounded,
            title: 'No Saved Stays',
            description:
                'Tap the heart icon on any hotel, room, or homestay to save it here for later.',
            actionText: 'Explore Stays',
            onAction: () => Get.find<StayNavigationController>().changeTab(0),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
          itemCount: favorites.length,
          separatorBuilder: (_, __) => AppSpacing.gapV16,
          itemBuilder: (context, index) {
            final stay = favorites[index];
            return StayCardWidget(
              stay: stay,
              onTap: () => Get.toNamed(
                AppRoutes.stayDetails,
                arguments: stay.id,
              ),
              onFavoriteToggle: (_) =>
                  controller.toggleFavorite(stay.id, stay.isFavorite),
            );
          },
        );
      }),
    );
  }
}
