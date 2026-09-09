import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/modules/home/controllers/home_controller.dart';
import 'package:sewasetu/modules/home/widgets/home_dynamic_search_bar_widget.dart';
import 'package:sewasetu/modules/home/widgets/home_location_header_widget.dart';
import 'package:sewasetu/modules/home/widgets/home_service_switcher_widget.dart';

/// Unified Swiggy-style top header canopy combining location header,
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
        decoration: BoxDecoration(
          color: themeColor,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(26),
          ),
          boxShadow: isDark
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 4, bottom: 2),
                child: HomeLocationHeaderWidget(),
              ),
              HomeServiceSwitcherWidget(),
              HomeDynamicSearchBarWidget(),
            ],
          ),
        ),
      );
    });
  }
}