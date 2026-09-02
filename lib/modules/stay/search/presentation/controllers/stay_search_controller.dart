import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/search/domain/usecases/search_stays_usecase.dart';
import 'package:sewasetu/modules/stay/property/domain/entities/stay_entity.dart';
import 'package:sewasetu/shared/enums/view_state.dart';

/// Controller handling property search, recent tags, and debounced queries.
class StaySearchController extends GetxController {
  final SearchStaysUseCase searchStaysUseCase;

  StaySearchController({required this.searchStaysUseCase});

  final TextEditingController textController = TextEditingController();
  final Rx<ViewState> state = ViewState.initial.obs;
  final RxList<StayEntity> searchResults = <StayEntity>[].obs;
  final RxList<String> recentSearches = <String>[
    'Homestay in Shillong',
    'PG near Commerce College Guwahati',
    'Beach Resort Goa',
    'Single Room Beltola',
  ].obs;

  final List<String> popularDestinations = [
    'Shillong',
    'Guwahati',
    'Goa',
    'Manali',
    'Jaipur',
  ];

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      state.value = ViewState.initial;
      return;
    }

    try {
      state.value = ViewState.loading;
      final results = await searchStaysUseCase(query);
      searchResults.assignAll(results);
      if (searchResults.isEmpty) {
        state.value = ViewState.empty;
      } else {
        state.value = ViewState.loaded;
      }
      if (!recentSearches.contains(query.trim())) {
        recentSearches.insert(0, query.trim());
      }
    } catch (e) {
      state.value = ViewState.error;
    }
  }

  void selectTag(String tag) {
    textController.text = tag;
    search(tag);
  }

  void clearSearch() {
    textController.clear();
    searchResults.clear();
    state.value = ViewState.initial;
  }
}
