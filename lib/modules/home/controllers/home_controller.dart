import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/core/services/location_service.dart';
import 'package:sewasetu/modules/shop/shop_navigator.dart';
import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/modules/stay/services/stay_service.dart';
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

  String get currentSearchPlaceholder => selectedService.value.searchPlaceholder;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
    ever(locationService.selectedCity, (_) => loadNearbyStays());
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
  }

  Future<void> selectService(HomeService service) async {
    selectedService.value = service;
    switch (service) {
      case HomeService.stay:
        await Get.toNamed(AppRoutes.stayList);
        selectedService.value = HomeService.stay;
        break;
      case HomeService.trips:
        await (TripsNavigator.toTrips() ?? Get.toNamed(AppRoutes.trips));
        selectedService.value = HomeService.stay;
        break;
      case HomeService.shop:
        await (ShopNavigator.toShop() ?? Get.toNamed(AppRoutes.shop));
        selectedService.value = HomeService.stay;
        break;
      case HomeService.rental:
        await Get.toNamed(AppRoutes.rentals);
        selectedService.value = HomeService.stay;
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
    if (area.isNotEmpty && area != 'GS Road / Christian Basti') {
      return area;
    }
    final city = locationService.selectedCity.value;
    if (!city.contains('Guwahati')) {
      return city.split(',').first.trim();
    }
    return 'Kamakhya Gate';
  }

  String get locationSubtitle {
    final city = locationService.selectedCity.value;
    if (city.contains('Guwahati')) {
      return 'Fatashil Hills, Guwahati, Assam, India';
    }
    return '$city, India';
  }

  void onSelectStayType(StayType type) {
    Get.toNamed(AppRoutes.stayList, arguments: type);
  }

  void onSelectDestination(String destination) {
    Get.toNamed(AppRoutes.staySearch, arguments: destination);
  }
}

