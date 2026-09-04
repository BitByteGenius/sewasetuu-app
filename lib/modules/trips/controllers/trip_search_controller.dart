import 'dart:async';
import 'package:get/get.dart';
import '../../../../shared/enums/view_state.dart';
import '../data/repositories/trips_repository.dart';
import '../data/repositories/trips_repository_impl.dart';
import '../models/destination_model.dart';
import '../models/trip_package_model.dart';

/// Controller powering responsive trip search with debouncing and history
class TripSearchController extends GetxController {
  final TripsRepository repository;

  TripSearchController({TripsRepository? repository})
      : repository = repository ?? TripsRepositoryImpl();

  final Rx<ViewState> state = ViewState.initial.obs;
  final RxString searchQuery = ''.obs;
  final RxList<TripPackageModel> searchResults = <TripPackageModel>[].obs;
  final RxList<DestinationModel> popularDestinations = <DestinationModel>[].obs;

  final RxList<String> recentSearches = <String>[
    'Shillong',
    'Manali Snow',
    'Goa Scuba',
    'Kerala Houseboat',
  ].obs;

  final List<String> quickKeywords = const [
    'Meghalaya',
    'Goa Beach',
    'Himalayas',
    'Ladakh',
    'Kaziranga',
    'Kashmir',
    'Adventure',
    'Honeymoon',
  ];

  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    _loadPopularDestinations();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }

  Future<void> _loadPopularDestinations() async {
    final dests = await repository.getPopularDestinations();
    popularDestinations.assignAll(dests);
  }

  void onQueryChanged(String query) {
    searchQuery.value = query;
    _debounceTimer?.cancel();

    if (query.trim().isEmpty) {
      searchResults.clear();
      state.value = ViewState.initial;
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 350), () {
      executeSearch(query);
    });
  }

  Future<void> executeSearch(String query) async {
    final clean = query.trim();
    if (clean.isEmpty) return;

    try {
      state.value = ViewState.loading;
      searchQuery.value = clean;

      // Add to recent searches
      if (!recentSearches.contains(clean)) {
        recentSearches.insert(0, clean);
        if (recentSearches.length > 8) recentSearches.removeLast();
      }

      final results = await repository.searchTrips(clean);
      searchResults.assignAll(results);

      state.value = results.isEmpty ? ViewState.empty : ViewState.loaded;
    } catch (_) {
      state.value = ViewState.error;
    }
  }

  void removeRecentSearch(String item) {
    recentSearches.remove(item);
  }

  void clearRecentSearches() {
    recentSearches.clear();
  }
}
