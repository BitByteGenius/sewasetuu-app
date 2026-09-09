import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/enums/view_state.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../controllers/trips_controller.dart';
import '../models/trip_package_model.dart';
import '../trips_navigator.dart';
import '../widgets/destination_card.dart';
import '../widgets/trip_loading_card.dart';
import '../widgets/trip_package_card.dart';
import '../widgets/trip_theme_card.dart';

/// Primary discovery hub for the Travel and Trips marketplace
class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  late final TripsController controller;

  // Filter tab for curated packages: 'All', 'Under 5 Days', '5+ Days', 'Best Rated'
  String _selectedDurationFilter = 'All';

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<TripsController>()
        ? Get.find<TripsController>()
        : Get.put(TripsController());
  }

  List<TripPackageModel> _applyPackageTabFilter(List<TripPackageModel> list) {
    if (_selectedDurationFilter == 'All') return list;
    if (_selectedDurationFilter == 'Under 5 Days') {
      return list.where((p) => p.durationDays <= 4).toList();
    }
    if (_selectedDurationFilter == '5+ Days') {
      return list.where((p) => p.durationDays >= 5).toList();
    }
    if (_selectedDurationFilter == 'Best Rated') {
      return list.where((p) => p.rating >= 4.8).toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Obx(() {
        final isLoading = controller.state.value == ViewState.loading &&
            controller.featuredPackages.isEmpty;

        return RefreshIndicator(
          onRefresh: controller.refreshFeed,
          color: isDark ? AppColors.primaryLight : AppColors.primary,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Hero Widget with Search Bar & Trust Badges
                // TripsHeroWidget(
                //   onSearchTap: () => TripsNavigator.toTripSearch(),
                //   onExploreDestinationsTap: () =>
                //       TripsNavigator.toDestinations(),
                //   onBackTap: Navigator.canPop(context)
                //       ? () => Navigator.pop(context)
                //       : null,
                // ),

                AppSpacing.gapV24,

                if (isLoading) ...[
                  _buildShimmerSection(isDark),
                ] else ...[
                  // 2. Travel Themes Horizontal Carousel
                  _buildThemesSection(isDark),

                  AppSpacing.gapV24,

                  // 3. Theme Filter Active Banner (if user picked a theme)
                  if (controller.selectedTheme.value != null) ...[
                    _buildThemeFilteredSection(isDark),
                    AppSpacing.gapV24,
                  ],

                  // 4. Featured Destinations Horizontal List
                  _buildDestinationsSection(isDark),

                  AppSpacing.gapV32,

                  // 5. Curated Tour Packages Catalog with Filter Tabs
                  _buildPackagesSection(isDark),

                  AppSpacing.gapV32,

                  // 6. Why Travel With SewaSetu
                  _buildValuePropositionsSection(isDark),

                  AppSpacing.gapV24,

                  // 7. Custom Itinerary & Group Inquiries Card
                  _buildCustomInquiryBanner(isDark),

                  const SizedBox(height: 48),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }

  // ---------------------------------------------------------------------------
  // TRAVEL THEMES
  // ---------------------------------------------------------------------------
  Widget _buildThemesSection(bool isDark) {
    if (controller.themes.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore By Travel Style',
                    style: AppTextStyles.titleMedium(isDark).copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Pick your preferred holiday mood & experience',
                    style: AppTextStyles.bodySmall(isDark),
                  ),
                ],
              ),
              if (controller.selectedTheme.value != null)
                TextButton(
                  onPressed: () => controller.selectTheme(null),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                  ),
                  child: Text(
                    'Clear',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.primaryLight
                          : AppColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ),
        AppSpacing.gapV12,
        SizedBox(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: controller.themes.length,
            itemBuilder: (context, index) {
              final theme = controller.themes[index];
              final isSelected =
                  controller.selectedTheme.value?.id == theme.id;
              return TripThemeCard(
                theme: theme,
                isSelected: isSelected,
                onTap: () => controller.selectTheme(theme),
              );
            },
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // THEME FILTERED SECTION
  // ---------------------------------------------------------------------------
  Widget _buildThemeFilteredSection(bool isDark) {
    final theme = controller.selectedTheme.value!;
    final filtered = controller.themeFilteredPackages;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceVariantDark.withAlpha(80)
                  : AppColors.surfaceVariantLight,
              borderRadius: AppRadius.radiusMd,
              border: Border.all(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
            child: Row(
              children: [
                Text(theme.emoji, style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${theme.name} Journeys',
                        style: AppTextStyles.titleSmall(isDark).copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '${filtered.length} curated packages found',
                        style: AppTextStyles.bodySmall(isDark),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => TripsNavigator.toTripList(
                    themeId: theme.id,
                    title: '${theme.name} Packages',
                  ),
                  child: const Text('View All'),
                ),
              ],
            ),
          ),
          AppSpacing.gapV16,
          if (filtered.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No packages currently found for ${theme.name}.',
                  style: AppTextStyles.bodyMedium(isDark),
                ),
              ),
            )
          else
            ...filtered.take(3).map((pkg) {
              return TripPackageCard(
                package: pkg,
                onTap: () => TripsNavigator.toTripDetails(pkg),
              );
            }),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // DESTINATIONS CAROUSEL
  // ---------------------------------------------------------------------------
  Widget _buildDestinationsSection(bool isDark) {
    if (controller.featuredDestinations.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top Destinations',
                      style: AppTextStyles.titleMedium(isDark).copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Iconic hill stations, coastal paradises & valleys',
                      style: AppTextStyles.bodySmall(isDark),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () => TripsNavigator.toDestinations(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        color: isDark
                            ? AppColors.primaryLight
                            : AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: isDark
                          ? AppColors.primaryLight
                          : AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AppSpacing.gapV12,
        SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: controller.featuredDestinations.length,
            itemBuilder: (context, index) {
              final destination = controller.featuredDestinations[index];
              return DestinationCard(
                destination: destination,
                width: 190,
                height: 260,
                onTap: () =>
                    TripsNavigator.toDestinationDetails(destination),
              );
            },
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // PACKAGES CATALOG WITH FILTER TABS
  // ---------------------------------------------------------------------------
  Widget _buildPackagesSection(bool isDark) {
    final allPackages = controller.featuredPackages;
    if (allPackages.isEmpty) return const SizedBox.shrink();

    final filtered = _applyPackageTabFilter(allPackages);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Curated Tour Packages',
                      style: AppTextStyles.titleMedium(isDark).copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'All-inclusive multi-day itineraries with stays & meals',
                      style: AppTextStyles.bodySmall(isDark),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () => TripsNavigator.toTripList(
                  title: 'All Tour Packages',
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Browse All', //(${allPackages.length})',
                      style: TextStyle(
                        color: isDark
                            ? AppColors.primaryLight
                            : AppColors.primary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: isDark
                          ? AppColors.primaryLight
                          : AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.gapV12,

          // Duration / category filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                'All',
                'Under 5 Days',
                '5+ Days',
                'Best Rated',
              ].map((filterName) {
                final isSelected = _selectedDurationFilter == filterName;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(filterName),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedDurationFilter = filterName;
                        });
                      }
                    },
                    selectedColor: isDark
                        ? AppColors.primaryLight
                        : AppColors.primary,
                    backgroundColor: isDark
                        ? AppColors.surfaceDark
                        : AppColors.surfaceLight,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? (isDark ? Colors.black : Colors.white)
                          : (isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight),
                      fontSize: 12,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.radiusFull,
                      side: BorderSide(
                        color: isSelected
                            ? Colors.transparent
                            : (isDark
                                ? AppColors.borderDark
                                : AppColors.borderLight),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          AppSpacing.gapV16,

          // Package Cards List
          if (filtered.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No packages match the selected criteria.',
                  style: AppTextStyles.bodyMedium(isDark),
                ),
              ),
            )
          else
            ...filtered.map((pkg) {
              return TripPackageCard(
                package: pkg,
                onTap: () => TripsNavigator.toTripDetails(pkg),
              );
            }),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // VALUE PROPOSITIONS: WHY TRAVEL WITH SEWASETU
  // ---------------------------------------------------------------------------
  Widget _buildValuePropositionsSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(25),
                    borderRadius: AppRadius.radiusSm,
                  ),
                  child: const Icon(
                    Icons.shield_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Why Travel With SewaSetu?',
                        style: AppTextStyles.titleMedium(isDark).copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Pioneering seamless, culturally immersive travel across India',
                        style: AppTextStyles.bodySmall(isDark),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppSpacing.gapV20,
            _buildValueItem(
              isDark,
              icon: Icons.verified_user_rounded,
              title: '100% Verified Local Operators',
              desc:
                  'Every guide, driver, and operator is vetted with valid government credentials and regional expertise.',
            ),
            const SizedBox(height: 14),
            _buildValueItem(
              isDark,
              icon: Icons.receipt_long_rounded,
              title: 'Transparent Pricing & Zero Hidden Fees',
              desc:
                  'Hotels, transfers, permits, and meals clearly itemized. What you see is exactly what you pay.',
            ),
            const SizedBox(height: 14),
            _buildValueItem(
              isDark,
              icon: Icons.support_agent_rounded,
              title: '24/7 Dedicated Trip Concierge',
              desc:
                  'Live assistance on WhatsApp and call from departure until your safe arrival back home.',
            ),
            const SizedBox(height: 14),
            _buildValueItem(
              isDark,
              icon: Icons.lock_clock_rounded,
              title: 'Flexible 25% Advance Booking',
              desc:
                  'Lock your departure slots and premium stays with only 25% down, with flexible rescheduling.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValueItem(
    bool isDark, {
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon,
            size: 18,
            color: isDark ? AppColors.primaryLight : AppColors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium(isDark).copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: AppTextStyles.bodySmall(isDark).copyWith(
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // CUSTOM INQUIRY BANNER
  // ---------------------------------------------------------------------------
  Widget _buildCustomInquiryBanner(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    const Color(0xFF1F2937),
                    const Color(0xFF111827),
                  ]
                : [
                    const Color(0xFFEFF6FF),
                    const Color(0xFFDBEAFE),
                  ],
          ),
          borderRadius: AppRadius.radiusLg,
          border: Border.all(
            color: isDark ? Colors.white12 : const Color(0xFFBFDBFE),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('🎒', style: TextStyle(fontSize: 22)),
                const SizedBox(width: 8),
                Text(
                  'Planning a Group or Custom Tour?',
                  style: TextStyle(
                    color: isDark ? Colors.white : const Color(0xFF1E3A8A),
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Customize itineraries for corporate retreats, family unions, or college expeditions. Our travel architects will design your perfect package within 24 hours.',
              style: TextStyle(
                color: isDark
                    ? Colors.white.withAlpha(200)
                    : const Color(0xFF1E40AF),
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
            AppSpacing.gapV16,
            AppButton.primary(
              text: 'Request Custom Itinerary',
              onPressed: () {
                _showCustomTripInquiryDialog(context, isDark);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomTripInquiryDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (dialogCtx) {
        final nameCtrl = TextEditingController();
        final phoneCtrl = TextEditingController();
        final destCtrl = TextEditingController();

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusLg),
          title: Row(
            children: const [
              Icon(Icons.flight_takeoff_rounded, color: AppColors.primary),
              SizedBox(width: 8),
              Text('Custom Trip Inquiry',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Tell us where you would like to travel and our certified travel planners will reach out with a personalized plan.',
                  style: TextStyle(fontSize: 12.5),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Your Full Name',
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'WhatsApp / Phone Number',
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: destCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Preferred Destination & Dates',
                    isDense: true,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogCtx);
                Get.snackbar(
                  'Inquiry Received! 🌟',
                  'Thank you! Our travel expert will connect on WhatsApp within 4 business hours.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.primary,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 4),
                  margin: const EdgeInsets.all(16),
                );
              },
              child: const Text('Submit Inquiry'),
            ),
          ],
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // SHIMMER LOADER
  // ---------------------------------------------------------------------------
  Widget _buildShimmerSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: const [
          TripLoadingCard(),
          TripLoadingCard(),
          TripLoadingCard(),
        ],
      ),
    );
  }
}

typedef TripsPage = TripsScreen;
