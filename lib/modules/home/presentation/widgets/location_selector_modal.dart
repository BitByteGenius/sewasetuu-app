import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/services/location_service.dart';
import 'package:sewasetu/shared/widgets/app_bottom_sheet.dart';

class CityLocationItem {
  final String city;
  final String state;
  final String stayCount;
  final String emoji;

  const CityLocationItem({
    required this.city,
    required this.state,
    required this.stayCount,
    required this.emoji,
  });
}

/// Interactive City / Location Selector Modal with instant search
class LocationSelectorModal extends StatefulWidget {
  const LocationSelectorModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LocationSelectorModal(),
    );
  }

  @override
  State<LocationSelectorModal> createState() => _LocationSelectorModalState();
}

class _LocationSelectorModalState extends State<LocationSelectorModal> {
  final TextEditingController _searchController = TextEditingController();
  final LocationService _locationService = Get.find<LocationService>();

  static const List<CityLocationItem> _allCities = [
    CityLocationItem(city: 'Guwahati', state: 'Assam', stayCount: '160+ Stays', emoji: '🏙️'),
    CityLocationItem(city: 'Shillong', state: 'Meghalaya', stayCount: '48+ Stays', emoji: '🌲'),
    CityLocationItem(city: 'Goa', state: 'India', stayCount: '120+ Stays', emoji: '🏖️'),
    CityLocationItem(city: 'Manali', state: 'Himachal Pradesh', stayCount: '85+ Stays', emoji: '🏔️'),
    CityLocationItem(city: 'Jaipur', state: 'Rajasthan', stayCount: '92+ Stays', emoji: '🏰'),
    CityLocationItem(city: 'Delhi NCR', state: 'Delhi', stayCount: '340+ Stays', emoji: '🏛️'),
    CityLocationItem(city: 'Bengaluru', state: 'Karnataka', stayCount: '280+ Stays', emoji: '💼'),
    CityLocationItem(city: 'Kolkata', state: 'West Bengal', stayCount: '145+ Stays', emoji: '🌉'),
  ];

  List<CityLocationItem> _filteredCities = _allCities;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        _filteredCities = _allCities;
      } else {
        _filteredCities = _allCities.where((c) {
          return c.city.toLowerCase().contains(query) || c.state.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBottomSheet(
      title: 'Select City or Region',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Input
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
              borderRadius: AppRadius.radiusMd,
            ),
            child: TextField(
              controller: _searchController,
              autofocus: false,
              style: AppTextStyles.bodyMedium(isDark),
              decoration: InputDecoration(
                hintText: 'Search city or state...',
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 20,
                  color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 18),
                        onPressed: () => _searchController.clear(),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          AppSpacing.gapV16,

          // GPS Current Location option
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (isDark ? AppColors.primaryLight : AppColors.primary).withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.my_location_rounded,
                color: isDark ? AppColors.primaryLight : AppColors.primary,
                size: 20,
              ),
            ),
            title: Text(
              'Use Current Location',
              style: AppTextStyles.titleMedium(isDark).copyWith(
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.primaryLight : AppColors.primary,
              ),
            ),
            subtitle: Text(
              'Guwahati, Assam (Detected via GPS)',
              style: AppTextStyles.bodySmall(isDark),
            ),
            onTap: () {
              _locationService.updateCity('Guwahati, Assam');
              Navigator.of(context).pop();
            },
          ),
          const Divider(),
          AppSpacing.gapV8,

          Text(
            'All Available Destinations',
            style: AppTextStyles.labelMedium(isDark).copyWith(
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
            ),
          ),
          AppSpacing.gapV8,

          // City List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _filteredCities.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = _filteredCities[index];
              final isCurrent = _locationService.selectedCity.value.contains(item.city);

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                leading: Text(item.emoji, style: const TextStyle(fontSize: 24)),
                title: Text(
                  item.city,
                  style: AppTextStyles.titleMedium(isDark).copyWith(
                    fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  '${item.state} • ${item.stayCount}',
                  style: AppTextStyles.bodySmall(isDark),
                ),
                trailing: isCurrent
                    ? Icon(
                        Icons.check_circle_rounded,
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                      )
                    : null,
                onTap: () {
                  _locationService.updateCity('${item.city}, ${item.state}');
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
