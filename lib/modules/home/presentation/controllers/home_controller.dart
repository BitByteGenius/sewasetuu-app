import 'package:get/get.dart';
import '../../../../core/services/location_service.dart';
import '../../../stay/property/domain/entities/stay_entity.dart';
import '../../../stay/property/domain/usecases/get_stays_usecase.dart';
import '../../../../shared/enums/stay_type.dart';
import '../../../../shared/enums/view_state.dart';

/// Controller managing the Home screen state, featured properties, and nearby feed.
class HomeController extends GetxController {
  final GetStaysUseCase getStaysUseCase;
  final LocationService locationService;

  HomeController({
    required this.getStaysUseCase,
    required this.locationService,
  });

  final Rx<ViewState> state = ViewState.initial.obs;
  final RxList<StayEntity> featuredStays = <StayEntity>[].obs;
  final RxList<StayEntity> nearbyStays = <StayEntity>[].obs;
  final RxInt selectedNavIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
    // Reactively refresh nearby stays when selected city changes
    ever(locationService.selectedCity, (_) => loadNearbyStays());
  }

  Future<void> loadHomeData() async {
    try {
      state.value = ViewState.loading;
      final featured = await getStaysUseCase.getFeatured();
      final nearby = await getStaysUseCase.getNearby(locationService.selectedCity.value);
      featuredStays.assignAll(featured);
      nearbyStays.assignAll(nearby);
      state.value = ViewState.loaded;
    } catch (e) {
      state.value = ViewState.error;
    }
  }

  Future<void> loadNearbyStays() async {
    try {
      final nearby = await getStaysUseCase.getNearby(locationService.selectedCity.value);
      nearbyStays.assignAll(nearby);
    } catch (_) {}
  }

  void onSelectStayType(StayType type) {
    // Navigate directly to Stay List with pre-selected category
    Get.toNamed('/stay/list', arguments: type);
  }

  void onSelectDestination(String city) {
    locationService.updateCity(city);
    Get.toNamed('/stay/list');
  }

  void switchNavTab(int index) {
    selectedNavIndex.value = index;
  }
}
