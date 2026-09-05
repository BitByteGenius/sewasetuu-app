import 'package:get/get.dart';
import '../data/datasources/rental_mock_datasource.dart';
import '../data/repositories/rental_repository.dart';
import '../models/vehicle_model.dart';
import 'rental_city_controller.dart';

/// Main home controller for the Rental module. Orchestrates city-specific discovery feeds.
class RentalController extends GetxController {
  final RentalRepository repository;
  final RentalCityController cityController;

  RentalController({
    required this.repository,
    required this.cityController,
  });

  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  final RxList<RentalBannerCampaign> campaigns = <RentalBannerCampaign>[].obs;
  final RxList<VehicleModel> featuredVehicles = <VehicleModel>[].obs;
  final RxList<VehicleModel> popularVehicles = <VehicleModel>[].obs;
  final RxList<VehicleModel> premiumVehicles = <VehicleModel>[].obs;
  final RxList<VehicleModel> categoryFilteredVehicles = <VehicleModel>[].obs;

  final Rx<RentalVehicleType> selectedCategoryTab = RentalVehicleType.all.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();

    // Whenever the user picks a new city, reload city-specific vehicle showcases
    ever(cityController.selectedCity, (_) {
      loadCityVehicles();
    });
  }

  Future<void> loadDashboardData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final camps = await repository.getCampaigns();
      campaigns.assignAll(camps);

      await loadCityVehicles();
    } catch (e) {
      errorMessage.value = 'Failed to load rental catalog. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadCityVehicles() async {
    final city = cityController.selectedCity.value;
    if (city == null) return;

    try {
      final cityId = city.id;
      final featured = await repository.getFeaturedVehicles(cityId);
      final popular = await repository.getPopularVehicles(cityId);
      final premium = await repository.getPremiumVehicles(cityId);
      final allCityVehicles = await repository.getVehicles(cityId: cityId);

      featuredVehicles.assignAll(featured);
      popularVehicles.assignAll(popular);
      premiumVehicles.assignAll(premium);

      _applyCategoryFilter(allCityVehicles);
    } catch (_) {
      // Retain existing lists on transient errors
    }
  }

  void selectCategoryTab(RentalVehicleType type) async {
    selectedCategoryTab.value = type;
    final city = cityController.selectedCity.value;
    if (city == null) return;

    final allCityVehicles = await repository.getVehicles(
      cityId: city.id,
      vehicleType: type == RentalVehicleType.all ? null : type,
    );
    categoryFilteredVehicles.assignAll(allCityVehicles);
  }

  void _applyCategoryFilter(List<VehicleModel> list) {
    if (selectedCategoryTab.value == RentalVehicleType.all) {
      categoryFilteredVehicles.assignAll(list);
    } else {
      categoryFilteredVehicles.assignAll(
        list.where((v) => v.vehicleType == selectedCategoryTab.value).toList(),
      );
    }
  }
}
