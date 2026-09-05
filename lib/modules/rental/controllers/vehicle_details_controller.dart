import 'package:get/get.dart';
import '../data/repositories/rental_repository.dart';
import '../models/rental_addon_model.dart';
import '../models/rental_pricing_model.dart';
import '../models/rental_review_model.dart';
import '../models/vehicle_model.dart';
import '../models/vehicle_variant_model.dart';
import 'rental_search_controller.dart';

/// Controller managing vehicle specifications, multi-image gallery, reviews, and addons.
class VehicleDetailsController extends GetxController {
  final RentalRepository repository;
  final RentalSearchController? searchController;

  VehicleDetailsController({
    required this.repository,
    this.searchController,
  });

  final RxBool isLoading = true.obs;
  final Rx<VehicleModel?> vehicle = Rx<VehicleModel?>(null);
  final RxInt activeImageIndex = 0.obs;
  final Rx<VehicleVariantModel?> selectedVariant = Rx<VehicleVariantModel?>(null);
  final RxList<RentalAddonModel> availableAddons = <RentalAddonModel>[].obs;
  final RxList<RentalReviewModel> reviews = <RentalReviewModel>[].obs;
  final RxInt activeTabIndex = 0.obs; // 0: Specs, 1: Features, 2: Reviews

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is VehicleModel) {
      setVehicle(args);
    } else if (args is String) {
      loadVehicleById(args);
    }
  }

  void setVehicle(VehicleModel v) {
    vehicle.value = v;
    if (v.variants.isNotEmpty) {
      selectedVariant.value = v.variants.first;
    }
    loadSupplementaryData(v);
  }

  Future<void> loadVehicleById(String id) async {
    try {
      isLoading.value = true;
      final v = await repository.getVehicleById(id);
      if (v != null) {
        setVehicle(v);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadSupplementaryData(VehicleModel v) async {
    try {
      isLoading.value = true;
      final addons = await repository.getAddonsForVehicle(v);
      final revs = await repository.getVehicleReviews(v.id);
      availableAddons.assignAll(addons);
      reviews.assignAll(revs);
    } finally {
      isLoading.value = false;
    }
  }

  void onImageChanged(int index) {
    activeImageIndex.value = index;
  }

  void selectVariant(VehicleVariantModel variant) {
    selectedVariant.value = variant;
  }

  void setTab(int index) {
    activeTabIndex.value = index;
  }

  /// Estimated price based on active search duration
  RentalPricingModel get estimatedPricing {
    final v = vehicle.value;
    if (v == null) {
      return RentalPricingModel.calculate(basePricePerDay: 0, durationDays: 1);
    }

    final durationDays = searchController?.searchModel.value.durationDays ?? 1;
    final pricePerDay = selectedVariant.value?.pricePerDay ?? v.pricePerDay;

    return RentalPricingModel.calculate(
      basePricePerDay: pricePerDay,
      durationDays: durationDays,
      securityDeposit: v.securityDeposit,
    );
  }
}
