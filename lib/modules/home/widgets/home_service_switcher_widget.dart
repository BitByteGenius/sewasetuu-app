import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/modules/home/controllers/home_controller.dart';
import 'swiggy_connected_tab_bar.dart';

/// Horizontal 4-service switcher bar matching Swiggy's connected tab layout
class HomeServiceSwitcherWidget extends StatelessWidget {
  const HomeServiceSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Obx(() {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final activeService = controller.selectedService.value;
        return SwiggyConnectedTabBar(
          activeService: activeService,
          onServiceChanged: (service) => controller.selectService(service),
          isDark: isDark,
        );
      }),
    );
  }
}
