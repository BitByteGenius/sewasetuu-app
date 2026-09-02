import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_shadows.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/modules/stay/search/presentation/controllers/stay_search_controller.dart';
import 'package:sewasetu/modules/stay/search/presentation/widgets/search_dates_step.dart';
import 'package:sewasetu/modules/stay/search/presentation/widgets/search_guests_step.dart';
import 'package:sewasetu/modules/stay/search/presentation/widgets/search_location_step.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';

/// Complete Multi-Step Search Experience with Destination, Dates, Guests and Stay Types
class StaySearchPage extends GetView<StaySearchController> {
  const StaySearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dateFormatter = DateFormat('dd MMM');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Find Your Ideal Stay',
          style: AppTextStyles.headlineSmall(isDark),
        ),
        actions: [
          TextButton(
            onPressed: controller.clearAll,
            child: Text(
              'Clear All',
              style: AppTextStyles.labelMedium(isDark).copyWith(
                color: isDark ? AppColors.primaryLight : AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Column(
                children: [
                  // 1. Where / Destination Accordion
                  _buildAccordionCard(
                    context: context,
                    isDark: isDark,
                    stepIndex: 0,
                    title: 'Where to?',
                    previewText: controller.textController.text.isNotEmpty
                        ? controller.textController.text
                        : 'I’m flexible (any destination)',
                    expandedContent: SearchLocationStep(
                      controller: controller.textController,
                      onSelectDestination: controller.setDestination,
                    ),
                  ),
                  AppSpacing.gapV16,

                  // 2. When / Dates Accordion
                  Obx(() {
                    final inDate = controller.checkInDate.value;
                    final outDate = controller.checkOutDate.value;
                    final dateText = (inDate != null && outDate != null)
                        ? '${dateFormatter.format(inDate)} – ${dateFormatter.format(outDate)}'
                        : 'Select dates';

                    return _buildAccordionCard(
                      context: context,
                      isDark: isDark,
                      stepIndex: 1,
                      title: 'When is your stay?',
                      previewText: dateText,
                      expandedContent: SearchDatesStep(
                        checkIn: controller.checkInDate.value,
                        checkOut: controller.checkOutDate.value,
                        flexibility: controller.flexibility.value,
                        onDatesSelected: controller.setDates,
                        onFlexibilityChanged: controller.setFlexibility,
                      ),
                    );
                  }),
                  AppSpacing.gapV16,

                  // 3. Who / Guests Accordion
                  Obx(() {
                    final totalGuests = controller.adultsCount.value + controller.childrenCount.value;
                    final rooms = controller.roomsCount.value;
                    final guestText = '$totalGuests Guests, $rooms Room${rooms > 1 ? 's' : ''}';

                    return _buildAccordionCard(
                      context: context,
                      isDark: isDark,
                      stepIndex: 2,
                      title: 'Who is coming?',
                      previewText: guestText,
                      expandedContent: SearchGuestsStep(
                        adults: controller.adultsCount.value,
                        children: controller.childrenCount.value,
                        rooms: controller.roomsCount.value,
                        onAdultsChanged: (val) => controller.adultsCount.value = val,
                        onChildrenChanged: (val) => controller.childrenCount.value = val,
                        onRoomsChanged: (val) => controller.roomsCount.value = val,
                      ),
                    );
                  }),
                  AppSpacing.gapV16,

                  // 4. Property Category Selector Accordion
                  Obx(() {
                    final currentType = controller.selectedStayType.value;
                    final typeText = currentType != null ? currentType.label : 'Any accommodation type';

                    return _buildAccordionCard(
                      context: context,
                      isDark: isDark,
                      stepIndex: 3,
                      title: 'Accommodation Category',
                      previewText: typeText,
                      expandedContent: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ChoiceChip(
                            label: const Text('✨ All Categories'),
                            selected: controller.selectedStayType.value == null,
                            selectedColor: isDark ? AppColors.primaryLight : AppColors.primary,
                            backgroundColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                            labelStyle: AppTextStyles.labelMedium(isDark).copyWith(
                              color: controller.selectedStayType.value == null
                                  ? (isDark ? Colors.black : Colors.white)
                                  : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                              fontWeight: controller.selectedStayType.value == null ? FontWeight.w800 : FontWeight.w500,
                            ),
                            onSelected: (_) => controller.selectedStayType.value = null,
                          ),
                          ...StayType.values.map((type) {
                            final isSelected = controller.selectedStayType.value == type;
                            return ChoiceChip(
                              label: Text('${type.emoji} ${type.label}'),
                              selected: isSelected,
                              selectedColor: isDark ? AppColors.primaryLight : AppColors.primary,
                              backgroundColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                              labelStyle: AppTextStyles.labelMedium(isDark).copyWith(
                                color: isSelected
                                    ? (isDark ? Colors.black : Colors.white)
                                    : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                              ),
                              onSelected: (selected) {
                                controller.selectedStayType.value = selected ? type : null;
                              },
                            );
                          }),
                        ],
                      ),
                    );
                  }),
                  AppSpacing.gapV24,
                ],
              ),
            ),
          ),

          // Bottom Search Floating Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              boxShadow: AppShadows.topNav,
              border: Border(
                top: BorderSide(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: AppButton.primary(
                text: 'Search Accommodations',
                icon: const Icon(Icons.search_rounded, color: Colors.white, size: 20),
                width: double.infinity,
                onPressed: controller.executeSearch,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccordionCard({
    required BuildContext context,
    required bool isDark,
    required int stepIndex,
    required String title,
    required String previewText,
    required Widget expandedContent,
  }) {
    return Obx(() {
      final isExpanded = controller.currentSearchStep.value == stepIndex;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: AppRadius.radiusLg,
          boxShadow: isExpanded ? AppShadows.md : AppShadows.sm,
          border: Border.all(
            color: isExpanded
                ? (isDark ? AppColors.primaryLight : AppColors.primary)
                : (isDark ? AppColors.borderDark : AppColors.borderLight),
            width: isExpanded ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                controller.currentSearchStep.value = isExpanded ? -1 : stepIndex;
              },
              borderRadius: AppRadius.radiusLg,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.titleMedium(isDark).copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (!isExpanded) ...[
                          const SizedBox(height: 4),
                          Text(
                            previewText,
                            style: AppTextStyles.bodySmall(isDark).copyWith(
                              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                            ),
                          ),
                        ],
                      ],
                    ),
                    Icon(
                      isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                      color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded) ...[
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: expandedContent,
              ),
            ],
          ],
        ),
      );
    });
  }
}
