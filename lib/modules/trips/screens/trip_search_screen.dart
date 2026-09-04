import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/enums/view_state.dart';
import '../controllers/trip_search_controller.dart';
import '../trips_navigator.dart';
import '../widgets/destination_card.dart';
import '../widgets/trip_loading_card.dart';
import '../widgets/trip_package_card.dart';
import '../widgets/trip_search_bar.dart';

/// Dedicated travel search screen with debounced live querying, recent searches, and destination suggestions
class TripSearchScreen extends StatefulWidget {
  final String? initialQuery;

  const TripSearchScreen({
    super.key,
    this.initialQuery,
  });

  @override
  State<TripSearchScreen> createState() => _TripSearchScreenState();
}

class _TripSearchScreenState extends State<TripSearchScreen> {
  late final TripSearchController controller;
  late final TextEditingController _textCtrl;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<TripSearchController>()
        ? Get.find<TripSearchController>()
        : Get.put(TripSearchController());

    _textCtrl = TextEditingController(text: widget.initialQuery ?? '');
    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      controller.executeSearch(widget.initialQuery!);
    }
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
        title: TripSearchBar(
          controller: _textCtrl,
          autoFocus: widget.initialQuery == null,
          hintText: 'Search destinations, states, trips...',
          onChanged: (val) => controller.onQueryChanged(val),
          onSubmitted: (val) => controller.executeSearch(val),
        ),
      ),
      body: Obx(() {
        final state = controller.state.value;
        final results = controller.searchResults;

        // 1. Initial State: Show Recent Searches & Trending Suggestions
        if (state == ViewState.initial) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recent Searches
                if (controller.recentSearches.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Searches',
                        style: AppTextStyles.titleSmall(isDark).copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextButton(
                        onPressed: () => controller.clearRecentSearches(),
                        child: Text(
                          'Clear',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.textMutedDark
                                : AppColors.textMutedLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: controller.recentSearches.map((item) {
                      return InkWell(
                        onTap: () {
                          _textCtrl.text = item;
                          controller.executeSearch(item);
                        },
                        borderRadius: AppRadius.radiusFull,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.surfaceVariantDark.withAlpha(60)
                                : AppColors.surfaceVariantLight,
                            borderRadius: AppRadius.radiusFull,
                            border: Border.all(
                              color: isDark
                                  ? AppColors.borderDark
                                  : AppColors.borderLight,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.history_rounded,
                                  size: 14, color: AppColors.primary),
                              const SizedBox(width: 6),
                              Text(
                                item,
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? AppColors.textPrimaryDark
                                      : AppColors.textPrimaryLight,
                                ),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () =>
                                    controller.removeRecentSearch(item),
                                child: const Icon(Icons.close_rounded,
                                    size: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  AppSpacing.gapV24,
                ],

                // Trending Keywords
                Text(
                  'Popular Search Topics',
                  style: AppTextStyles.titleSmall(isDark).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: controller.quickKeywords.map((kw) {
                    return ActionChip(
                      label: Text(kw),
                      avatar: const Icon(Icons.trending_up_rounded,
                          size: 14, color: AppColors.secondary),
                      labelStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      onPressed: () {
                        _textCtrl.text = kw;
                        controller.executeSearch(kw);
                      },
                    );
                  }).toList(),
                ),
                AppSpacing.gapV24,

                // Recommended Destinations
                if (controller.popularDestinations.isNotEmpty) ...[
                  Text(
                    'Featured Travel Destinations',
                    style: AppTextStyles.titleSmall(isDark).copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.popularDestinations.length,
                      itemBuilder: (context, index) {
                        final dest = controller.popularDestinations[index];
                        return DestinationCard(
                          destination: dest,
                          width: 170,
                          height: 220,
                          onTap: () =>
                              TripsNavigator.toDestinationDetails(dest),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          );
        }

        // 2. Loading State
        if (state == ViewState.loading) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 4,
            itemBuilder: (context, index) => const TripLoadingCard(),
          );
        }

        // 3. Empty Search State
        if (state == ViewState.empty || results.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search_off_rounded,
                    size: 64,
                    color: Colors.grey,
                  ),
                  AppSpacing.gapV16,
                  Text(
                    'No Trips Found for "${controller.searchQuery.value}"',
                    style: AppTextStyles.titleMedium(isDark).copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Try searching by state (e.g. Meghalaya, Himachal, Goa) or style (e.g. Adventure, Snow, Beach).',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySmall(isDark),
                  ),
                ],
              ),
            ),
          );
        }

        // 4. Results List
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: results.length,
          itemBuilder: (context, index) {
            final pkg = results[index];
            return TripPackageCard(
              package: pkg,
              onTap: () => TripsNavigator.toTripDetails(pkg),
            );
          },
        );
      }),
    );
  }
}
