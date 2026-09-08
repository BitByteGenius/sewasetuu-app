import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/modules/home/controllers/home_controller.dart';
import 'home_service_tab_widget.dart';

/// Horizontal 4-service switcher bar inspired by Swiggy's multi-service switcher
class HomeServiceSwitcherWidget extends StatelessWidget {
  const HomeServiceSwitcherWidget({super.key});

  static const List<HomeService> _services = [
    HomeService.stay,
    HomeService.trips,
    HomeService.shop,
    HomeService.rental,
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final horizontalPadding = screenWidth < 360 ? 12.0 : 16.0;
        final cardGap = screenWidth < 360 ? 6.0 : 8.0;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 6.0,
          ),
          child: Obx(() {
            final activeService = controller.selectedService.value;

            return Row(
              children: _services.map((service) {
                final isSelected = activeService == service;
                final isLast = service == _services.last;

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: isLast ? 0 : cardGap),
                    child: HomeServiceTabWidget(
                      service: service,
                      isSelected: isSelected,
                      onTap: () => controller.selectService(service),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
        );
      },
    );
  }
}
