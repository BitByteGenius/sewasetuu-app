import 'package:get/get.dart';
import '../data/repositories/rental_repository.dart';
import '../models/vehicle_model.dart';
import 'rental_filter_controller.dart';
import 'rental_search_controller.dart';

/// Controller responsible for querying, filtering, and sorting the vehicle list feed.
class VehicleListController extends GetxController {
  final RentalRepository repository;
  final RentalSearchController searchController;
  final RentalFilterController filterController;

  VehicleListController({
    required this.repository,
    required this.searchController,
    required this.filterController,
  });

  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxList<VehicleModel> vehicles = <VehicleModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadVehicles();

    // Listen to changes in search criteria, filters, or sorting
    ever(searchController.searchModel, (_) => loadVehicles());
    ever(filterController.criteria, (_) => loadVehicles());
    ever(filterController.currentSort, (_) => loadVehicles());
  }

  Future<void> loadVehicles() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final results = await repository.searchVehicles(
        searchController.searchModel.value,
        filters: filterController.criteria.value,
        sort: filterController.currentSort.value,
      );

      vehicles.assignAll(results);
    } catch (e) {
      errorMessage.value = 'Failed to load vehicles. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void quickFilterType(RentalVehicleType type) {
    searchController.setVehicleType(type);
    filterController.setVehicleType(type);
  }
}
