import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/models/stay_filter_criteria.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';

/// GetX Controller for handling advanced stay filter states
class FilterController extends GetxController {
  final Rx<StayType?> selectedType = Rx<StayType?>(null);
  final Rx<RangeValues> priceRange = const RangeValues(200, 10000).obs;
  final RxDouble minRating = 0.0.obs;
  final RxList<String> selectedAmenities = <String>[].obs;
  final RxBool verifiedOnly = false.obs;

  final List<String> availableAmenities = [
    'High-speed WiFi',
    'Air Conditioner',
    '3 Meals Included',
    'Free Breakfast',
    'Laundry Service',
    'Free Parking',
    'Bonfire & BBQ',
    'Swimming Pool',
    'Kitchenette',
    '24x7 Security',
  ];

  void initialize(StayFilterCriteria? initialCriteria) {
    if (initialCriteria != null) {
      selectedType.value = initialCriteria.stayType;
      if (initialCriteria.minPrice != null || initialCriteria.maxPrice != null) {
        priceRange.value = RangeValues(
          initialCriteria.minPrice ?? 200,
          initialCriteria.maxPrice ?? 10000,
        );
      }
      minRating.value = initialCriteria.minRating ?? 0.0;
      selectedAmenities.assignAll(initialCriteria.amenities);
      verifiedOnly.value = initialCriteria.verifiedOnly ?? false;
    }
  }

  void toggleAmenity(String amenity) {
    if (selectedAmenities.contains(amenity)) {
      selectedAmenities.remove(amenity);
    } else {
      selectedAmenities.add(amenity);
    }
  }

  void reset() {
    selectedType.value = null;
    priceRange.value = const RangeValues(200, 10000);
    minRating.value = 0.0;
    selectedAmenities.clear();
    verifiedOnly.value = false;
  }

  StayFilterCriteria buildCriteria() {
    return StayFilterCriteria(
      stayType: selectedType.value,
      minPrice: priceRange.value.start > 200 ? priceRange.value.start : null,
      maxPrice: priceRange.value.end < 10000 ? priceRange.value.end : null,
      minRating: minRating.value > 0.0 ? minRating.value : null,
      amenities: selectedAmenities.toList(),
      verifiedOnly: verifiedOnly.value ? true : null,
    );
  }
}

typedef StayFilterController = FilterController;
