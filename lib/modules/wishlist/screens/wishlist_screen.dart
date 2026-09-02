import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/modules/stay/stay.dart';
import 'package:sewasetu/modules/wishlist/bindings/wishlist_binding.dart';
import 'package:sewasetu/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import 'package:sewasetu/shared/widgets/app_empty_state.dart';
import 'package:sewasetu/shared/widgets/app_skeleton.dart';

/// Saved properties & wishlist screen with collection filtering
class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late final WishlistController controller;
  String selectedCollection = 'All Saved';

  final List<String> collections = [
    'All Saved',
    'Weekend Getaways',
    'Workation PGs',
    'Mountain Cottages',
  ];

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<WishlistController>()) {
      WishlistBinding().dependencies();
    }
    controller = Get.find<WishlistController>();
  }

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Collection filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: AppSpacing.horizontalLg,
            child: Row(
              children: collections.map((col) {
                final isSelected = selectedCollection == col;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(col),
                    selected: isSelected,
                    selectedColor: isDark ? AppColors.primaryLight : AppColors.primary,
                    backgroundColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                    labelStyle: AppTextStyles.labelMedium(isDark).copyWith(
                      color: isSelected
                          ? (isDark ? Colors.black : Colors.white)
                          : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                    ),
                    onSelected: (val) {
                      if (val) setState(() => selectedCollection = col);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          AppSpacing.gapV12,

          Expanded(
            child: Obx(() {
              if (controller.state.value == ViewState.loading) {
                return ListView.separated(
                  padding: AppSpacing.screenPadding,
                  itemCount: 3,
                  separatorBuilder: (context, index) => AppSpacing.gapV16,
                  itemBuilder: (context, index) => const StayCardSkeleton(),
                );
              }

              if (controller.savedStays.isEmpty) {
                return AppEmptyState(
                  icon: Icons.favorite_outline_rounded,
                  title: 'Your Wishlist is Empty',
                  description: 'Tap the heart icon on any accommodation to save your favorite rooms and homestays here.',
                  actionText: 'Explore Stays',
                  onAction: () => Get.toNamed(AppRoutes.stayList),
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
                    onFavoriteToggle: (_) {
                      controller.removeFavorite(stay.id);
                      Get.snackbar(
                        'Removed from Saved',
                        '${stay.title} has been removed from your wishlist.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

typedef WishlistPage = WishlistScreen;
