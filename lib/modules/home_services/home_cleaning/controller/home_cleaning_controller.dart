import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import '../models/home_cleaning_category_model.dart';
import '../screens/kitchen_cleaning_screen.dart';

/// Controller managing state and user interactions for the Home Cleaning module.
class HomeCleaningController extends GetxController {
  final state = ViewState.loaded.obs;
  final categories = <HomeCleaningCategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  /// Initial dataset matching the exact 5 items in the reference screenshot
  void loadCategories() {
    categories.assignAll(const [
      HomeCleaningCategoryModel(
        id: 'full_house',
        title: 'Full House\nCleaning',
        imageUrl:
            'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&w=500&q=80',
        fallbackIcon: Icons.home_rounded,
        description: 'Complete deep cleaning for all rooms & living areas',
      ),
      HomeCleaningCategoryModel(
        id: 'bathroom',
        title: 'Bathroom\nCleaning',
        imageUrl:
            'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=500&q=80',
        fallbackIcon: Icons.bathtub_rounded,
        description: 'Sanitization & stain removal for bathrooms',
      ),
      HomeCleaningCategoryModel(
        id: 'kitchen',
        title: 'Kitchen\nCleaning',
        imageUrl:
            'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?auto=format&fit=crop&w=500&q=80',
        fallbackIcon: Icons.countertops_rounded,
        description: 'Degreasing stove, chimney, cabinets & countertops',
      ),
      HomeCleaningCategoryModel(
        id: 'sofa',
        title: 'Sofa Cleaning',
        imageUrl:
            'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=500&q=80',
        fallbackIcon: Icons.chair_rounded,
        description: 'Shampooing & vacuuming fabric or leather sofas',
      ),
      HomeCleaningCategoryModel(
        id: 'book_by_room',
        title: 'Book By Room',
        imageUrl:
            'https://images.unsplash.com/photo-1616594039964-ae9021a400a0?auto=format&fit=crop&w=500&q=80',
        fallbackIcon: Icons.king_bed_rounded,
        description: 'Custom room-by-room cleaning configuration',
      ),
    ]);
  }

  /// Action when a user selects a cleaning category card
  void onCategorySelected(HomeCleaningCategoryModel category) {
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }

    if (category.id == 'kitchen' ||
        category.title.toLowerCase().contains('kitchen')) {
      Get.to(() => const KitchenCleaningScreen());
      return;
    }

    Get.snackbar(
      'Service Selected',
      'Opening ${category.title.replaceAll('\n', ' ')} booking flow...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: AppColors.textWhite,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
