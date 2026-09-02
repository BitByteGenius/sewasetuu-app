import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/core/services/location_service.dart';
import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/modules/stay/services/stay_service.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';
import 'package:sewasetu/shared/enums/view_state.dart';

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

  void onSelectStayType(StayType type) {
    Get.toNamed(AppRoutes.stayList, arguments: type);
  }

  void onSelectDestination(String destination) {
    Get.toNamed(AppRoutes.staySearch, arguments: destination);
  }
}
