import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/modules/stay/models/stay_filter_criteria.dart';
import 'package:sewasetu/modules/stay/widgets/search_dates_step.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';
import 'package:sewasetu/shared/enums/view_state.dart';

/// Complete Stay Search controller managing location, dates, guests and criteria
class SearchController extends GetxController {
  SearchController({dynamic searchStaysUseCase});

  final TextEditingController textController = TextEditingController();
  final Rx<ViewState> state = ViewState.initial.obs;
  final RxList<PropertyModel> searchResults = <PropertyModel>[].obs;

  // Search Flow Observables
  final RxInt currentSearchStep = 0.obs;
  final Rx<DateTime?> checkInDate = Rx<DateTime?>(null);
  final Rx<DateTime?> checkOutDate = Rx<DateTime?>(null);
  final Rx<DateFlexibility> flexibility = DateFlexibility.exact.obs;
  final RxInt adultsCount = 2.obs;
  final RxInt childrenCount = 0.obs;
  final RxInt roomsCount = 1.obs;
  final Rx<StayType?> selectedStayType = Rx<StayType?>(null);

  final RxList<String> recentSearches = <String>[
    'Homestay in Shillong',
    'PG near Commerce College Guwahati',
    'Beach Resort Goa',
    'Single Room Beltola',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    checkInDate.value = now.add(const Duration(days: 1));
    checkOutDate.value = now.add(const Duration(days: 3));

    if (Get.arguments is String) {
      textController.text = Get.arguments as String;
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
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
    currentSearchStep.value = 1;
  }

  void clearAll() {
    textController.clear();
    adultsCount.value = 2;
    childrenCount.value = 0;
    roomsCount.value = 1;
    selectedStayType.value = null;
    currentSearchStep.value = 0;
  }

  /// Compile search criteria and navigate to property results listing
  void executeSearch() {
    final criteria = StayFilterCriteria(
      stayType: selectedStayType.value,
      city: textController.text.trim().isNotEmpty ? textController.text.trim() : null,
    );

    if (textController.text.trim().isNotEmpty && !recentSearches.contains(textController.text.trim())) {
      recentSearches.insert(0, textController.text.trim());
    }

    Get.toNamed(
      AppRoutes.stayList,
      arguments: criteria,
    );
  }
}

typedef StaySearchController = SearchController;
