import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/core/services/location_service.dart';
import 'package:sewasetu/modules/shop/shop_navigator.dart';
import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/modules/stay/services/stay_service.dart';
import 'package:sewasetu/modules/rental/controllers/rental_navigation_controller.dart';
import 'package:sewasetu/modules/shop/controllers/shop_navigation_controller.dart';
import 'package:sewasetu/modules/stay/controllers/stay_navigation_controller.dart';
import 'package:sewasetu/modules/trips/controllers/trips_navigation_controller.dart';
import 'package:sewasetu/modules/trips/trips_navigator.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';
import 'package:sewasetu/shared/enums/view_state.dart';

/// Available primary services for the top switcher
enum HomeService {
  stay,
  trips,
  shop,
  rental,
}

/// Extension providing metadata for each primary service
extension HomeServiceExtension on HomeService {
  String get title {
    switch (this) {
      case HomeService.stay:
        return 'Stay';
      case HomeService.trips:
        return 'Tours & Trips';
      case HomeService.shop:
        return 'Shop';
      case HomeService.rental:
        return 'Vehicle Rental';
    }
  }

  String get searchPlaceholder {
    switch (this) {
      case HomeService.stay:
        return "Search hotels, rooms, homestays...";
      case HomeService.trips:
        return "Search destinations & tour packages...";
      case HomeService.shop:
        return "Search products from India...";
      case HomeService.rental:
        return "Search cars and bikes for rent...";
    }
  }

  String get shortTitle {
    switch (this) {
      case HomeService.stay:
        return 'Stays';
      case HomeService.trips:
        return 'Trips';
      case HomeService.shop:
        return 'Shop';
      case HomeService.rental:
        return 'Rental';
    }
  }

  String get iconAssetPath {
    switch (this) {
      case HomeService.stay:
        return 'assets/images/service_stay_3d.jpg';
      case HomeService.trips:
        return 'assets/images/service_trips_3d.jpg';
      case HomeService.shop:
        return 'assets/images/service_shop_3d.jpg';
      case HomeService.rental:
        return 'assets/images/service_rental_3d.jpg';
    }
  }

  Color themeColor(bool isDark) {
    if (!isDark) return Colors.white;
    switch (this) {
      case HomeService.stay:
        return const Color(0xFF0D1E20);
      case HomeService.trips:
        return const Color(0xFF13162C);
      case HomeService.shop:
        return const Color(0xFF1C140D);
      case HomeService.rental:
        return const Color(0xFF0E1A2C);
    }
  }

  Color headerBgColor(bool isDark) => themeColor(isDark);

  Color get accentColor {
    switch (this) {
      case HomeService.stay:
        return const Color(0xFF14B8A6);
      case HomeService.trips:
        return const Color(0xFF818CF8);
      case HomeService.shop:
        return const Color(0xFFF97316);
      case HomeService.rental:
        return const Color(0xFF38BDF8);
    }
  }
}

/// Controller for Home Discovery screen and Main Shell navigation
class HomeController extends GetxController {
  final StayService stayService;
  final LocationService locationService;

  HomeController({
    StayService? stayService,
    LocationService? locationService,
    dynamic getStaysUseCase,
  })  : stayService = stayService ?? StayService(),
        locationService = locationService ?? (Get.isRegistered<LocationService>() ? Get.find<LocationService>() : LocationService());

  // Observables
  final RxInt selectedNavIndex = 0.obs;
  final Rx<ViewState> state = ViewState.initial.obs;
  final RxList<PropertyModel> featuredStays = <PropertyModel>[].obs;
  final RxList<PropertyModel> nearbyStays = <PropertyModel>[].obs;
  final RxList<PropertyModel> recommendedStays = <PropertyModel>[].obs;
  final RxList<PropertyModel> recentlyViewedStays = <PropertyModel>[].obs;
  final RxInt unreadNotificationCount = 2.obs;

  // Service Switcher Observable
  final Rx<HomeService> selectedService = HomeService.stay.obs;

  /// Returns whether the active primary service's bottom navigation bar is currently on its
  /// main discovery feed (tab 0: Stay Explore, Trips Discover, Shop Home, Rental Explore).
  ///
  /// When true: The sticky HomeLocationHeaderWidget and scrolling ServiceTab (service switcher + search) are displayed.
  /// When false (user navigated to Search, Saved, Bookings, Categories, Cart, Orders, Vehicles, Favorites):
  /// The HomeLocationHeaderWidget and ServiceTab are hidden so the sub-tab view takes full screen.
  bool get isMainFeedActive {
    switch (selectedService.value) {
      case HomeService.stay:
        final stayNav = Get.isRegistered<StayNavigationController>()
            ? Get.find<StayNavigationController>()
            : Get.put(StayNavigationController(), permanent: true);
        return stayNav.selectedIndex.value == 0;

      case HomeService.trips:
        final tripsNav = Get.isRegistered<TripsNavigationController>()
            ? Get.find<TripsNavigationController>()
            : Get.put(TripsNavigationController(), permanent: true);
        return tripsNav.selectedIndex.value == 0;

      case HomeService.shop:
        final shopNav = Get.isRegistered<ShopNavigationController>()
            ? Get.find<ShopNavigationController>()
            : Get.put(ShopNavigationController(), permanent: true);
        return shopNav.currentIndex.value == 0;

      case HomeService.rental:
        final rentalNav = Get.isRegistered<RentalNavigationController>()
            ? Get.find<RentalNavigationController>()
            : Get.put(RentalNavigationController(), permanent: true);
        return rentalNav.currentIndex.value == 0;
    }
  }

  String get currentSearchPlaceholder => selectedService.value.searchPlaceholder;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
    ever(locationService.selectedCity, (_) => loadNearbyStays());
    // Auto-detect and set user GPS location on startup
    locationService.initAutoLocation();
  }

  Future<void> loadHomeData() async {
    try {
      state.value = ViewState.loading;
      final allStays = await stayService.getStays();
      final featured = await stayService.getFeaturedStays();
      final nearby = await stayService.getNearbyStays(city: locationService.selectedCity.value);

      featuredStays.assignAll(featured);
      nearbyStays.assignAll(nearby);
      recommendedStays.assignAll(allStays.reversed.take(4).toList());
      recentlyViewedStays.assignAll(allStays.take(3).toList());

      state.value = ViewState.loaded;
    } catch (_) {
      state.value = ViewState.error;
    }
  }

  Future<void> loadNearbyStays() async {
    final nearby = await stayService.getNearbyStays(city: locationService.selectedCity.value);
    nearbyStays.assignAll(nearby);
  }

  void switchNavTab(int index) {
    selectedNavIndex.value = index;
    switch (index) {
      case 1:
        Get.toNamed(AppRoutes.stayList);
        break;
      case 2:
        Get.toNamed(AppRoutes.booking);
        break;
      case 3:
        Get.toNamed(AppRoutes.wishlist);
        break;
      case 4:
        Get.toNamed(AppRoutes.profile);
        break;
    }
  }

  void selectService(HomeService service) {
    selectedService.value = service;
    switch (service) {
      case HomeService.stay:
        if (Get.isRegistered<StayNavigationController>()) {
          Get.find<StayNavigationController>().toExplore();
        }
        break;
      case HomeService.trips:
        if (Get.isRegistered<TripsNavigationController>()) {
          Get.find<TripsNavigationController>().toDiscover();
        }
        break;
      case HomeService.shop:
        if (Get.isRegistered<ShopNavigationController>()) {
          Get.find<ShopNavigationController>().toHome();
        }
        break;
      case HomeService.rental:
        if (Get.isRegistered<RentalNavigationController>()) {
          Get.find<RentalNavigationController>().toExplore();
        }
        break;
    }
  }

  void onSearchTap() {
    switch (selectedService.value) {
      case HomeService.stay:
        Get.toNamed(AppRoutes.staySearch);
        break;
      case HomeService.trips:
        TripsNavigator.toTripSearch();
        break;
      case HomeService.shop:
        ShopNavigator.toSearch();
        break;
      case HomeService.rental:
        Get.toNamed(AppRoutes.rentals);
        break;
    }
  }

  void onVoiceSearchTap() {
    Get.snackbar(
      'Voice Search',
      'Voice search for ${selectedService.value.title} is coming soon!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1E293B),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.mic_rounded, color: Color(0xFF14B8A6)),
    );
  }

  void onProfileTap() {
    Get.toNamed(AppRoutes.profile);
  }

  String get locationTitle {
    final area = locationService.selectedArea.value;
    if (area.isNotEmpty) {
      return area;
    }
    return locationService.selectedCity.value.split(',').first.trim();
  }

  String get locationSubtitle {
    final city = locationService.selectedCity.value;
    if (city.isNotEmpty) {
      return city;
    }
    return 'Guwahati, Assam, India';
  }

  void onSelectStayType(StayType type) {
    Get.toNamed(AppRoutes.stayList, arguments: type);
  }

  void onSelectDestination(String destination) {
    Get.toNamed(AppRoutes.staySearch, arguments: destination);
  }
}

