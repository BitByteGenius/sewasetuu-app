import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_network_image.dart';
import '../controllers/destination_controller.dart';
import '../models/destination_model.dart';
import '../trips_navigator.dart';
import '../widgets/trip_package_card.dart';

/// Comprehensive destination travel guide featuring packages, about information, and weather guides
class DestinationDetailsScreen extends StatefulWidget {
  final DestinationModel destination;

  const DestinationDetailsScreen({
    super.key,
    required this.destination,
  });

  @override
  State<DestinationDetailsScreen> createState() =>
      _DestinationDetailsScreenState();
}

class _DestinationDetailsScreenState extends State<DestinationDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final DestinationController controller;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<DestinationController>(tag: widget.destination.id);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dest = widget.destination;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              leading: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(120),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white, size: 16),
                ),
                onPressed: () => Get.back(),
              ),
              actions: [
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(120),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.search_rounded,
                        color: Colors.white, size: 18),
                  ),
                  onPressed: () => TripsNavigator.toTripSearch(
                    initialQuery: dest.name,
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    AppNetworkImage(
                      imageUrl: dest.heroImage,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withAlpha(60),
                            Colors.transparent,
                            Colors.black.withAlpha(180),
                            Colors.black.withAlpha(240),
                          ],
                          stops: const [0.0, 0.4, 0.75, 1.0],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: AppRadius.radiusSm,
                                ),
                                child: Text(
                                  dest.state.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: AppRadius.radiusSm,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.star_rounded,
                                        color: AppColors.secondary, size: 13),
                                    const SizedBox(width: 3),
                                    Text(
                                      '${dest.rating} (${dest.reviewCount})',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            dest.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            dest.shortDescription,
                            style: TextStyle(
                              color: Colors.white.withAlpha(220),
                              fontSize: 12.5,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: Container(
                  color:
                      isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor:
                        isDark ? AppColors.primaryLight : AppColors.primary,
                    indicatorWeight: 3,
                    labelColor:
                        isDark ? AppColors.primaryLight : AppColors.primary,
                    unselectedLabelColor: isDark
                        ? AppColors.textMutedDark
                        : AppColors.textMutedLight,
                    labelStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                    tabs: const [
                      Tab(text: 'Trip Packages'),
                      Tab(text: 'About & Highlights'),
                      Tab(text: 'When to Visit'),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Tab 1: Available Packages
            Obx(() {
              final pkgs = controller.packages;

              if (pkgs.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.beach_access_rounded,
                            size: 48, color: Colors.grey),
                        AppSpacing.gapV12,
                        Text(
                          'No trips currently listed for ${dest.name}',
                          style: AppTextStyles.titleSmall(isDark),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: pkgs.length,
                itemBuilder: (context, index) {
                  final pkg = pkgs[index];
                  return TripPackageCard(
                    package: pkg,
                    onTap: () => TripsNavigator.toTripDetails(pkg),
                  );
                },
              );
            }),

            // Tab 2: About & Highlights
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About ${dest.name}',
                    style: AppTextStyles.titleMedium(isDark).copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  AppSpacing.gapV8,
                  Text(
                    dest.description,
                    style: AppTextStyles.bodyMedium(isDark).copyWith(
                      height: 1.5,
                    ),
                  ),
                  AppSpacing.gapV20,

                  // Tags & Experiences
                  Text(
                    'Signature Experiences & Tags',
                    style: AppTextStyles.titleSmall(isDark).copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  AppSpacing.gapV8,
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: dest.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.surfaceVariantDark
                              : AppColors.surfaceVariantLight,
                          borderRadius: AppRadius.radiusSm,
                        ),
                        child: Text(
                          '#$tag',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.primaryLight
                                : AppColors.primary,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  AppSpacing.gapV24,

                  // Local Culture & Heritage Note
                  AppCard(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('🏛️', style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Local Cultural Heritage',
                                style: AppTextStyles.titleSmall(isDark).copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'All trips in ${dest.name} are led by certified local operators ensuring respectful cultural interactions and direct economic support to artisan communities.',
                                style: AppTextStyles.bodySmall(isDark).copyWith(
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tab 3: When to Visit & Weather
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Best Season to Travel',
                    style: AppTextStyles.titleMedium(isDark).copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  AppSpacing.gapV8,
                  AppCard(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withAlpha(25),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.wb_sunny_rounded,
                              color: AppColors.primary, size: 24),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recommended Window',
                                style: AppTextStyles.labelSmall(isDark),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                dest.bestTimeToVisit,
                                style: AppTextStyles.titleMedium(isDark).copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: isDark
                                      ? AppColors.primaryLight
                                      : AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.gapV20,

                  // Popular Months Chips
                  if (dest.popularMonths.isNotEmpty) ...[
                    Text(
                      'Peak & Favorable Months',
                      style: AppTextStyles.titleSmall(isDark).copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    AppSpacing.gapV8,
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: dest.popularMonths.map((m) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.primaryContainerDark
                                : AppColors.primaryContainer,
                            borderRadius: AppRadius.radiusMd,
                          ),
                          child: Text(
                            m,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                              color: isDark
                                  ? AppColors.primaryLight
                                  : AppColors.primary,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    AppSpacing.gapV20,
                  ],

                  // Travel Packing Checklist Tip
                  AppCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Essential Packing Guidance',
                          style: AppTextStyles.titleSmall(isDark).copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        AppSpacing.gapV8,
                        Text(
                          '• Carry comfortable walking shoes or waterproof trekking boots.\n• Bring breathable layers for daytime and warm fleeces for evening mountain drops.\n• Keep photo identification and state permit documents handy.',
                          style: AppTextStyles.bodySmall(isDark).copyWith(
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
