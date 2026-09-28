import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/core/services/location_service.dart';
import 'package:sewasetu/modules/stay/data/repositories/stay_repository_impl.dart';
import 'package:sewasetu/modules/stay/domain/repositories/stay_repository.dart';
import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/modules/stay/models/stay_category_model.dart';
import 'package:sewasetu/modules/stay/models/stay_filter_criteria.dart';
import 'package:sewasetu/modules/stay/widgets/search_dates_step.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';
import 'package:sewasetu/shared/enums/view_state.dart';

/// Redesigned Stay Search controller managing quick categories from model configuration, 
/// location radius, production-ready 400m map filtering, price/rating filters and criteria execution.
class SearchController extends GetxController {
  final IStayRepository _stayRepository;

  SearchController({
    IStayRepository? stayRepository,
    dynamic searchStaysUseCase,
  }) : _stayRepository = stayRepository ??
            (Get.isRegistered<IStayRepository>()
                ? Get.find<IStayRepository>()
                : StayRepositoryImpl());

  final TextEditingController textController = TextEditingController();
  final Rx<ViewState> state = ViewState.initial.obs;
  final RxList<PropertyModel> searchResults = <PropertyModel>[].obs;
  final RxList<PropertyModel> propertiesWithin400m = <PropertyModel>[].obs;

  // Category Configuration Model Registry
  List<StayCategoryModel> get categories => StayCategoryConfig.defaultCategories;

  // Search & Filter Observables
  final RxString selectedCategory = 'All'.obs;
  final Rx<StayType?> selectedStayType = Rx<StayType?>(null);
  final RxString selectedLocationName = 'Kamakhya Gate, Guwahati'.obs;
  final Rx<double?> userLatitude = Rx<double?>(26.1557);
  final Rx<double?> userLongitude = Rx<double?>(91.7088);
  final RxBool isLocating = false.obs;

  // Additional Filter Observables
  final RxInt priceRangeIndex = 0.obs; // 0: All, 1: <5k, 2: 5k-15k, 3: 15k+
  final Rx<double?> minRating = Rx<double?>(null);
  final RxBool verifiedOnly = false.obs;
  final Rx<String?> furnishingStatus = Rx<String?>(null);

  // Map state
  final Rx<PropertyModel?> selectedMapProperty = Rx<PropertyModel?>(null);
  final RxBool is400mRadiusOnlyMap = true.obs;

  // Backward compatibility multi-step search observables
  final RxInt currentSearchStep = 0.obs;
  final Rx<DateTime?> checkInDate = Rx<DateTime?>(null);
  final Rx<DateTime?> checkOutDate = Rx<DateTime?>(null);
  final Rx<DateFlexibility> flexibility = DateFlexibility.exact.obs;
  final RxInt adultsCount = 2.obs;
  final RxInt childrenCount = 0.obs;
  final RxInt roomsCount = 1.obs;

  final RxList<String> recentSearches = <String>[
    'Homestay in Shillong',
    'PG near Commerce College Guwahati',
    'Beach Resort Goa',
    '1BHK near Kamakhya Gate',
    '1RK Beltola',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    checkInDate.value = now.add(const Duration(days: 1));
    checkOutDate.value = now.add(const Duration(days: 3));

    if (Get.arguments is String) {
      textController.text = Get.arguments as String;
    } else if (Get.arguments is StayType) {
      selectedStayType.value = Get.arguments as StayType;
      selectedCategory.value = selectedStayType.value!.label;
    }

    _syncLocationService();
    loadAndFilterStays();
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  void _syncLocationService() {
    if (Get.isRegistered<LocationService>()) {
      final loc = Get.find<LocationService>();
      if (loc.selectedArea.value.isNotEmpty) {
        selectedLocationName.value = '${loc.selectedArea.value}, ${loc.selectedCity.value}';
      } else {
        selectedLocationName.value = loc.selectedCity.value;
      }
      if (loc.selectedLat.value != null && loc.selectedLng.value != null) {
        userLatitude.value = loc.selectedLat.value;
        userLongitude.value = loc.selectedLng.value;
      }
    }
  }

  Future<void> useCurrentGpsLocation() async {
    try {
      isLocating.value = true;
      if (Get.isRegistered<LocationService>()) {
        final loc = Get.find<LocationService>();
        final success = await loc.useCurrentGpsLocation();
        if (success) {
          selectedLocationName.value = '${loc.selectedArea.value}, ${loc.selectedCity.value}';
          userLatitude.value = loc.selectedLat.value;
          userLongitude.value = loc.selectedLng.value;
          textController.text = loc.selectedArea.value;
        }
      } else {
        final position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            timeLimit: Duration(seconds: 10),
          ),
        );
        userLatitude.value = position.latitude;
        userLongitude.value = position.longitude;
        selectedLocationName.value = 'Current Location';
      }
      await loadAndFilterStays();
    } catch (_) {
    } finally {
      isLocating.value = false;
    }
  }

  void selectCategory(String categoryCode) {
    if (selectedCategory.value == categoryCode) {
      selectedCategory.value = 'All';
      selectedStayType.value = null;
    } else {
      selectedCategory.value = categoryCode;
      selectedStayType.value = _mapCodeToStayType(categoryCode);
    }
    loadAndFilterStays();
  }

  StayType? _mapCodeToStayType(String code) {
    switch (code.toLowerCase()) {
      case 'homestay':
        return StayType.homestay;
      case 'mess':
        return StayType.mess;
      case 'hotel':
        return StayType.hotel;
      case 'room':
        return StayType.room;
      case 'pg':
        return StayType.pg;
      default:
        return null;
    }
  }

  void setPriceRange(int index) {
    priceRangeIndex.value = index;
    loadAndFilterStays();
  }

  void setMinRating(double? rating) {
    minRating.value = rating;
    loadAndFilterStays();
  }

  void toggleVerifiedOnly() {
    verifiedOnly.value = !verifiedOnly.value;
    loadAndFilterStays();
  }

  void setFurnishingStatus(String? status) {
    furnishingStatus.value = status;
    loadAndFilterStays();
  }

  double calculateDistanceFromUser(double lat, double lng) {
    final uLat = userLatitude.value ?? 26.1557;
    final uLng = userLongitude.value ?? 91.7088;
    return Geolocator.distanceBetween(uLat, uLng, lat, lng);
  }

  String formatDistanceText(double meters) {
    if (meters < 1000) {
      return '${meters.round()} m away';
    }
    return '${(meters / 1000).toStringAsFixed(1)} km away';
  }

  Future<void> loadAndFilterStays() async {
    try {
      state.value = ViewState.loading;

      double? minP;
      double? maxP;
      if (priceRangeIndex.value == 1) {
        maxP = 5000;
      } else if (priceRangeIndex.value == 2) {
        minP = 5000;
        maxP = 15000;
      } else if (priceRangeIndex.value == 3) {
        minP = 15000;
      }

      final criteria = StayFilterCriteria(
        stayType: selectedStayType.value,
        roomCategory: selectedCategory.value,
        minPrice: minP,
        maxPrice: maxP,
        minRating: minRating.value,
        verifiedOnly: verifiedOnly.value,
        city: textController.text.trim().isNotEmpty
            ? textController.text.trim()
            : null,
      );

      final rawResults = await _stayRepository.getStays(
        filter: criteria,
        searchQuery: textController.text.trim(),
      );

      // Client-side additional filtering (furnishing status)
      final filtered = rawResults.where((stay) {
        if (furnishingStatus.value != null && furnishingStatus.value!.isNotEmpty) {
          if (stay.furnishingStatus == null ||
              !stay.furnishingStatus!
                  .toLowerCase()
                  .contains(furnishingStatus.value!.toLowerCase())) {
            return false;
          }
        }
        return true;
      }).toList();

      searchResults.assignAll(filtered);

      // Compute properties within 400m radius of current/selected location
      final uLat = userLatitude.value ?? 26.1557;
      final uLng = userLongitude.value ?? 91.7088;

      final nearby400m = rawResults.where((stay) {
        final dist = Geolocator.distanceBetween(uLat, uLng, stay.latitude, stay.longitude);
        return dist <= 400.0;
      }).toList();

      propertiesWithin400m.assignAll(nearby400m);

      // Set map initial selection
      final activeMapList = is400mRadiusOnlyMap.value && nearby400m.isNotEmpty
          ? nearby400m
          : filtered;
      if (activeMapList.isNotEmpty) {
        selectedMapProperty.value = activeMapList.first;
      } else {
        selectedMapProperty.value = null;
      }

      state.value = filtered.isEmpty ? ViewState.empty : ViewState.loaded;
    } catch (_) {
      state.value = ViewState.error;
    }
  }

  void selectMapProperty(PropertyModel stay) {
    selectedMapProperty.value = stay;
  }

  void toggle400mRadiusOnlyMap() {
    is400mRadiusOnlyMap.value = !is400mRadiusOnlyMap.value;
    final activeMapList = is400mRadiusOnlyMap.value && propertiesWithin400m.isNotEmpty
        ? propertiesWithin400m
        : searchResults;
    if (activeMapList.isNotEmpty) {
      selectedMapProperty.value = activeMapList.first;
    }
  }

  void setDates(DateTime start, DateTime end) {
    checkInDate.value = start;
    checkOutDate.value = end;
  }

  void setFlexibility(DateFlexibility flex) {
    flexibility.value = flex;
  }

  void setDestination(String dest) {
    textController.text = dest;
    loadAndFilterStays();
  }

  void clearAll() {
    textController.clear();
    selectedCategory.value = 'All';
    selectedStayType.value = null;
    priceRangeIndex.value = 0;
    minRating.value = null;
    verifiedOnly.value = false;
    furnishingStatus.value = null;
    adultsCount.value = 2;
    childrenCount.value = 0;
    roomsCount.value = 1;
    currentSearchStep.value = 0;
    loadAndFilterStays();
  }

  Future<void> performAsyncSearch(String query) async {
    textController.text = query;
    await loadAndFilterStays();
  }

  /// Compile search criteria and navigate to property results listing
  void executeSearch() {
    double? minP;
    double? maxP;
    if (priceRangeIndex.value == 1) {
      maxP = 5000;
    } else if (priceRangeIndex.value == 2) {
      minP = 5000;
      maxP = 15000;
    } else if (priceRangeIndex.value == 3) {
      minP = 15000;
    }

    final criteria = StayFilterCriteria(
      stayType: selectedStayType.value,
      roomCategory: selectedCategory.value,
      minPrice: minP,
      maxPrice: maxP,
      minRating: minRating.value,
      verifiedOnly: verifiedOnly.value,
      city: textController.text.trim().isNotEmpty
          ? textController.text.trim()
          : null,
      userLatitude: userLatitude.value,
      userLongitude: userLongitude.value,
    );

    if (textController.text.trim().isNotEmpty &&
        !recentSearches.contains(textController.text.trim())) {
      recentSearches.insert(0, textController.text.trim());
    }

    Get.toNamed(
      AppRoutes.stayList,
      arguments: criteria,
    );
  }

  void openPropertyDetails(PropertyModel property) {
    Get.toNamed(
      AppRoutes.stayDetails,
      arguments: property.id,
    );
  }
}

typedef StaySearchController = SearchController;
