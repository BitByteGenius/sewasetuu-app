import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_bar/app_bar.dart';
import '../controllers/trips_controller.dart';
import '../models/destination_model.dart';
import '../trips_navigator.dart';
import '../widgets/destination_card.dart';

/// Screen displaying all available travel destinations across India with region filtering
class DestinationsScreen extends StatefulWidget {
  const DestinationsScreen({super.key});

  @override
  State<DestinationsScreen> createState() => _DestinationsScreenState();
}

class _DestinationsScreenState extends State<DestinationsScreen> {
  late final TripsController controller;
  String _selectedRegion = 'All';

  final List<String> regions = const [
    'All',
    'Northeast',
    'Himalayas & North',
    'South & Coastal',
    'West & Desert',
    'Islands',
  ];

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<TripsController>()
        ? Get.find<TripsController>()
        : Get.put(TripsController());
  }

  List<DestinationModel> _filterByRegion(List<DestinationModel> all) {
    if (_selectedRegion == 'All') return all;

    return all.where((dest) {
      final state = dest.state.toLowerCase();
      switch (_selectedRegion) {
        case 'Northeast':
          return state.contains('meghalaya') ||
              state.contains('assam') ||
              state.contains('sikkim') ||
              state.contains('arunachal');
        case 'Himalayas & North':
          return state.contains('himachal') ||
              state.contains('kashmir') ||
              state.contains('ladakh') ||
              state.contains('uttarakhand');
        case 'South & Coastal':
          return state.contains('kerala') || state.contains('goa');
        case 'West & Desert':
          return state.contains('rajasthan');
        case 'Islands':
          return state.contains('andaman');
        default:
          return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: SewaAppBar(
        titleText: 'Explore Destinations',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            tooltip: 'Search Destinations',
            onPressed: () => TripsNavigator.toTripSearch(),
          ),
        ],
      ),
      body: Obx(() {
        final filteredList = _filterByRegion(controller.allDestinations);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Region Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: regions.map((region) {
                  final isSelected = _selectedRegion == region;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(region),
                      selected: isSelected,
                      selectedColor: isDark
                          ? AppColors.primaryLight
                          : AppColors.primary,
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
                        if (val) {
                          setState(() {
                            _selectedRegion = region;
                          });
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const Divider(height: 1),

            // Destinations Count & Label
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                'Showing ${filteredList.length} Destinations',
                style: AppTextStyles.bodySmall(isDark).copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.textMutedDark
                      : AppColors.textSecondaryLight,
                ),
              ),
            ),

            // Destinations Grid
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.76,
                    ),
                    itemBuilder: (context, index) {
                      final dest = filteredList[index];
                      return DestinationCard(
                        destination: dest,
                        width: double.infinity,
                        height: double.infinity,
                        onTap: () => TripsNavigator.toDestinationDetails(dest),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
