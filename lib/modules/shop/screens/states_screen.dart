import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../controllers/shop_controller.dart';
import '../widgets/shop_empty_state.dart';
import '../widgets/shop_header_widget.dart';
import '../widgets/shop_search_bar.dart';
import '../widgets/state_card.dart';

/// Screen listing all available Indian states and Union Territories
class StatesScreen extends StatefulWidget {
  const StatesScreen({super.key});

  @override
  State<StatesScreen> createState() => _StatesScreenState();
}

class _StatesScreenState extends State<StatesScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchQuery = '';
  String _selectedRegion = 'All';

  final List<String> _regions = const [
    'All',
    'North East',
    'East',
    'North',
    'West',
    'South',
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final shopCtrl = Get.isRegistered<ShopController>()
        ? Get.find<ShopController>()
        : Get.put(ShopController());

    return Scaffold(
      appBar: const ShopHeaderWidget(
        title: 'Indian States',
        subtitle: 'Explore traditional crafts by region',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Search input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ShopSearchBar(
              controller: _searchCtrl,
              hintText: 'Filter states (e.g. Assam, Bihar, Rajasthan)...',
              readOnly: false,
              onChanged: (val) {
                setState(() => _searchQuery = val.trim().toLowerCase());
              },
              onClear: () {
                setState(() => _searchQuery = '');
              },
            ),
          ),
          // Region chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: _regions.map((region) {
                final isSelected = _selectedRegion == region;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(region),
                    selected: isSelected,
                    selectedColor:
                        isDark ? AppColors.primaryLight : AppColors.primary,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          isSelected ? FontWeight.w800 : FontWeight.w600,
                      color: isSelected
                          ? (isDark ? Colors.black : Colors.white)
                          : (isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight),
                    ),
                    onSelected: (val) {
                      if (val) setState(() => _selectedRegion = region);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1),
          // State Grid
          Expanded(
            child: Obx(() {
              final allStates = shopCtrl.allStates;

              final filtered = allStates.where((state) {
                final matchRegion = _selectedRegion == 'All' ||
                    state.region.toLowerCase() == _selectedRegion.toLowerCase();
                final matchQuery = _searchQuery.isEmpty ||
                    state.name.toLowerCase().contains(_searchQuery) ||
                    state.culturalHighlights.any(
                        (h) => h.toLowerCase().contains(_searchQuery));
                return matchRegion && matchQuery;
              }).toList();

              if (filtered.isEmpty) {
                return const ShopEmptyState(
                  title: 'No States Found',
                  message: 'Try adjusting your region filter or search term.',
                  icon: Icons.map_outlined,
                );
              }

              return ListView.separated(
                padding: AppSpacing.screenPadding,
                itemCount: filtered.length,
                separatorBuilder: (context, index) => AppSpacing.gapV16,
                itemBuilder: (context, index) {
                  return StateCard(stateModel: filtered[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
