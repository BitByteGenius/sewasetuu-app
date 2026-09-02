import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/core/services/location_service.dart';
import 'package:sewasetu/modules/stay/property/domain/entities/stay_entity.dart';
import 'package:sewasetu/modules/stay/property/domain/usecases/get_stays_usecase.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';
import 'package:sewasetu/shared/enums/view_state.dart';

/// Controller for Home Discovery screen and Main Shell navigation
class HomeController extends GetxController {
  final GetStaysUseCase getStaysUseCase;
  final LocationService locationService;

  HomeController({
    required this.getStaysUseCase,
    required this.locationService,
  });

  // Observables
  final RxInt selectedNavIndex = 0.obs;
  final Rx<ViewState> state = ViewState.initial.obs;
  final RxList<StayEntity> featuredStays = <StayEntity>[].obs;
  final RxList<StayEntity> nearbyStays = <StayEntity>[].obs;
  final RxList<StayEntity> recommendedStays = <StayEntity>[].obs;
  final RxList<StayEntity> recentlyViewedStays = <StayEntity>[].obs;
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
      final allStays = await getStaysUseCase();
      final featured = await getStaysUseCase.getFeatured();
      final nearby = await getStaysUseCase.getNearby(locationService.selectedCity.value);

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
    final nearby = await getStaysUseCase.getNearby(locationService.selectedCity.value);
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
