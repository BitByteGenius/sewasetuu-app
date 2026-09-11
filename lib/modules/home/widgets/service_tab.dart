import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/modules/home/controllers/home_controller.dart';
import 'package:sewasetu/modules/home/widgets/home_dynamic_search_bar_widget.dart';
import 'package:sewasetu/modules/home/widgets/home_service_switcher_widget.dart';

/// connected service tab switcher, and dynamic search bar into one continuous surface.
class ServiceTab extends StatelessWidget {
  const ServiceTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      final activeService = controller.selectedService.value;
      final themeColor = activeService.themeColor(isDark);

      return AnimatedContainer(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOut,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: themeColor,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
          boxShadow: isDark
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.22),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            HomeServiceSwitcherWidget(),
            HomeDynamicSearchBarWidget(),
            SizedBox(height: 6),
          ],
        ),
      );
    });
  }
}