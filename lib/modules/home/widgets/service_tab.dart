import 'package:flutter/material.dart';
import 'package:sewasetu/modules/home/widgets/home_dynamic_search_bar_widget.dart';
import 'package:sewasetu/modules/home/widgets/home_service_switcher_widget.dart';

class ServiceTab extends StatelessWidget {
  const ServiceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF090D16),
            Color(0xFF0F172A),
            Color(0xFF142033),
          ],
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 4),
          HomeServiceSwitcherWidget(),
          HomeDynamicSearchBarWidget(),
        ],
      ),
    );
  }
}