import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/core/services/location_service.dart';
import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/modules/stay/models/stay_filter_criteria.dart';
import 'package:sewasetu/modules/stay/services/stay_service.dart';
import 'package:sewasetu/modules/stay/widgets/stay_sorting_sheet.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';
import 'package:sewasetu/shared/enums/view_state.dart';

enum StayViewMode { list, grid, map }

/// Controller managing the stay listing feed, category tabs, sorting, and map view
class StayController extends GetxController {
  final StayService stayService = StayService();

  final Rx<ViewState> state = ViewState.initial.obs;
  final RxList<PropertyModel> stays = <PropertyModel>[].obs;
  final RxList<PropertyModel> featuredStays = <PropertyModel>[].obs;
  final RxList<PropertyModel> nearbyStays = <PropertyModel>[].obs;
  final RxList<PropertyModel> recommendedStays = <PropertyModel>[].obs;
  final RxList<PropertyModel> recentlyViewedStays = <PropertyModel>[].obs;

  final Rx<StayType?> selectedCategory = Rx<StayType?>(null);
  final Rx<StayFilterCriteria> currentFilter = const StayFilterCriteria().obs;
  final Rx<StayViewMode> viewMode = StayViewMode.list.obs;
  final Rx<StaySortOption> currentSort = StaySortOption.recommended.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is StayType) {
      selectedCategory.value = Get.arguments as StayType;
      currentFilter.value = currentFilter.value.copyWith(stayType: selectedCategory.value);
    } else if (Get.arguments is StayFilterCriteria) {
      currentFilter.value = Get.arguments as StayFilterCriteria;
      selectedCategory.value = currentFilter.value.stayType;
    }
    loadStays();
    if (Get.isRegistered<LocationService>()) {
      ever(Get.find<LocationService>().selectedCity, (_) => _loadNearbyStays());
    }
  }

  Future<void> _loadNearbyStays() async {
    try {
      if (Get.isRegistered<LocationService>()) {
        final city = Get.find<LocationService>().selectedCity.value;
        final nearby = await stayService.getNearbyStays(city: city);
        nearbyStays.assignAll(nearby);
      }
    } catch (_) {}
  }

  Future<void> loadStays() async {
    try {
      state.value = ViewState.loading;
      final result = await stayService.getStays(filter: currentFilter.value);
      final allStays = await stayService.getStays();
      final featured = await stayService.getFeaturedStays();

      String currentCity = 'Guwahati';
      if (Get.isRegistered<LocationService>()) {
        currentCity = Get.find<LocationService>().selectedCity.value;
      }
      final nearby = await stayService.getNearbyStays(city: currentCity);

      featuredStays.assignAll(featured);
      nearbyStays.assignAll(nearby);
      recommendedStays.assignAll(allStays.reversed.take(4).toList());
      recentlyViewedStays.assignAll(allStays.take(3).toList());

      // Apply in-memory sort
      _applySorting(result);

      if (stays.isEmpty && result.isEmpty) {
        state.value = ViewState.empty;
      } else {
        state.value = ViewState.loaded;
      }
    } catch (_) {
      state.value = ViewState.error;
    }
  }

  void onSelectStayType(StayType type) {
    selectedCategory.value = type;
    currentFilter.value = currentFilter.value.copyWith(stayType: type);
    Get.toNamed(AppRoutes.stayList, arguments: type);
  }

  void onSelectDestination(String destination) {
    Get.toNamed(AppRoutes.staySearch, arguments: destination);
  }

  void onCategorySelected(StayType? type) {
    selectedCategory.value = type;
    currentFilter.value = currentFilter.value.copyWith(stayType: type);
    loadStays();
  }

  void applyFilter(StayFilterCriteria criteria) {
    currentFilter.value = criteria;
    selectedCategory.value = criteria.stayType;
    loadStays();
  }

  void applySort(StaySortOption option) {
    currentSort.value = option;
    final currentList = List<PropertyModel>.from(stays);
    _applySorting(currentList);
  }

  void _applySorting(List<PropertyModel> list) {
    switch (currentSort.value) {
      case StaySortOption.priceLowToHigh:
        list.sort((a, b) => a.pricePerNight.compareTo(b.pricePerNight));
        break;
      case StaySortOption.priceHighToLow:
        list.sort((a, b) => b.pricePerNight.compareTo(a.pricePerNight));
        break;
      case StaySortOption.ratingHighToLow:
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case StaySortOption.recommended:
        list.sort((a, b) => (b.isFeatured ? 1 : 0).compareTo(a.isFeatured ? 1 : 0));
        break;
    }
    stays.assignAll(list);
  }

  void toggleFavorite(String stayId, bool currentFavorite) async {
    final index = stays.indexWhere((s) => s.id == stayId);
    if (index != -1) {
      final updated = stays[index].copyWith(isFavorite: !currentFavorite);
      stays[index] = updated;
      await stayService.toggleFavorite(stayId, currentFavorite);
    }
  }

  void setViewMode(StayViewMode mode) {
    viewMode.value = mode;
  }
}

typedef StayListController = StayController;
