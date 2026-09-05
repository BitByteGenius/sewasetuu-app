import 'package:get/get.dart';
import '../data/repositories/rental_repository.dart';
import '../models/vehicle_model.dart';

/// Controller managing active vehicle filters, multi-criteria sheet, and sorting.
class RentalFilterController extends GetxController {
  final Rx<RentalFilterCriteria> criteria = const RentalFilterCriteria().obs;
  final Rx<RentalSortOption> currentSort = RentalSortOption.recommended.obs;

  // Staging state for the filter bottom sheet so users can apply/cancel cleanly
  final Rx<RentalVehicleType> tempVehicleType = RentalVehicleType.all.obs;
  final Rx<String?> tempCategory = Rx<String?>(null);
  final RxDouble tempMinPrice = 0.0.obs;
  final RxDouble tempMaxPrice = 10000.0.obs;
  final RxString tempTransmission = 'All'.obs;
  final RxString tempFuelType = 'All'.obs;
  final RxInt tempMinSeats = 0.obs;
  final RxDouble tempMinRating = 0.0.obs;
  final RxBool tempPremiumOnly = false.obs;

  int get activeFilterCount => criteria.value.activeFilterCount;
  bool get hasActiveFilters => criteria.value.hasActiveFilters;

  void openFilterSheet() {
    // Populate temp fields from active criteria
    tempVehicleType.value = criteria.value.vehicleType;
    tempCategory.value = criteria.value.category;
    tempMinPrice.value = criteria.value.minPrice ?? 0.0;
    tempMaxPrice.value = criteria.value.maxPrice ?? 10000.0;
    tempTransmission.value = criteria.value.transmission ?? 'All';
    tempFuelType.value = criteria.value.fuelType ?? 'All';
    tempMinSeats.value = criteria.value.minSeats ?? 0;
    tempMinRating.value = criteria.value.minRating ?? 0.0;
    tempPremiumOnly.value = criteria.value.premiumOnly ?? false;
  }

  void applyTempFilters() {
    criteria.value = RentalFilterCriteria(
      vehicleType: tempVehicleType.value,
      category: tempCategory.value,
      minPrice: tempMinPrice.value > 0 ? tempMinPrice.value : null,
      maxPrice: tempMaxPrice.value < 10000 ? tempMaxPrice.value : null,
      transmission: tempTransmission.value != 'All' ? tempTransmission.value : null,
      fuelType: tempFuelType.value != 'All' ? tempFuelType.value : null,
      minSeats: tempMinSeats.value > 0 ? tempMinSeats.value : null,
      minRating: tempMinRating.value > 0 ? tempMinRating.value : null,
      premiumOnly: tempPremiumOnly.value ? true : null,
    );
  }

  void resetFilters() {
    criteria.value = const RentalFilterCriteria();
    tempVehicleType.value = RentalVehicleType.all;
    tempCategory.value = null;
    tempMinPrice.value = 0.0;
    tempMaxPrice.value = 10000.0;
    tempTransmission.value = 'All';
    tempFuelType.value = 'All';
    tempMinSeats.value = 0;
    tempMinRating.value = 0.0;
    tempPremiumOnly.value = false;
  }

  void setSortOption(RentalSortOption sort) {
    currentSort.value = sort;
  }

  void setVehicleType(RentalVehicleType type) {
    criteria.value = criteria.value.copyWith(vehicleType: type);
  }

  void setCategory(String? cat) {
    criteria.value = criteria.value.copyWith(category: cat);
  }
}
