import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import 'package:sewasetu/shared/widgets/app_empty_state.dart';
import 'package:sewasetu/shared/widgets/app_loader.dart';
import 'package:sewasetu/modules/stay/property/presentation/widgets/stay_card_widget.dart';
import 'package:sewasetu/modules/wishlist/presentation/controllers/wishlist_controller.dart';

/// Saved properties & wishlist screen.
class WishlistPage extends GetView<WishlistController> {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Places',
          style: AppTextStyles.headlineSmall(isDark),
        ),
      ),
      body: Obx(() {
        if (controller.state.value == ViewState.loading) {
          return const Center(child: AppLoader());
        }

        if (controller.savedStays.isEmpty) {
          return const AppEmptyState(
            icon: Icons.favorite_outline_rounded,
            title: 'Your Wishlist is Empty',
            description: 'Tap the heart icon on any stay to save your favorite rooms and homestays here.',
          );
        }

        return ListView.separated(
          padding: AppSpacing.screenPadding,
          itemCount: controller.savedStays.length,
          separatorBuilder: (context, index) => AppSpacing.gapV16,
          itemBuilder: (context, index) {
            final stay = controller.savedStays[index];
            return StayCardWidget(
              stay: stay.copyWith(isFavorite: true),
              onTap: () => Get.toNamed(AppRoutes.stayDetails, arguments: stay.id),
              onFavoriteToggle: (_) => controller.removeFavorite(stay.id),
            );
          },
        );
      }),
    );
  }
}
