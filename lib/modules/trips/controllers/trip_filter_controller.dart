import 'package:get/get.dart';
import '../../../../shared/enums/view_state.dart';
import '../data/repositories/trips_repository.dart';
import '../data/repositories/trips_repository_impl.dart';
import '../models/destination_model.dart';
import '../models/trip_filter_model.dart';
import '../models/trip_package_model.dart';
import '../models/trip_theme_model.dart';

/// Controller powering multi-attribute package filtering and sorting
class TripFilterController extends GetxController {
  final TripsRepository repository;

  TripFilterController({TripsRepository? repository})
      : repository = repository ?? TripsRepositoryImpl();

  final Rx<ViewState> state = ViewState.initial.obs;
  final Rx<TripFilterModel> currentFilter = const TripFilterModel().obs;
  final RxList<TripPackageModel> filteredPackages = <TripPackageModel>[].obs;

  final RxList<DestinationModel> availableDestinations =
      <DestinationModel>[].obs;
  final RxList<TripThemeModel> availableThemes = <TripThemeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMetadataAndPackages();
  }

  Future<void> _loadMetadataAndPackages() async {
    try {
      state.value = ViewState.loading;

      final results = await Future.wait([
        repository.getAllDestinations(),
        repository.getThemes(),
        repository.filterTrips(currentFilter.value),
      ]);

      availableDestinations.assignAll(results[0] as List<DestinationModel>);
      availableThemes.assignAll(results[1] as List<TripThemeModel>);
      filteredPackages.assignAll(results[2] as List<TripPackageModel>);

      state.value =
          filteredPackages.isEmpty ? ViewState.empty : ViewState.loaded;
    } catch (_) {
      state.value = ViewState.error;
    }
  }

  Future<void> applyFilter(TripFilterModel filter) async {
    currentFilter.value = filter;
    try {
      state.value = ViewState.loading;
      final results = await repository.filterTrips(filter);
      filteredPackages.assignAll(results);
      state.value = results.isEmpty ? ViewState.empty : ViewState.loaded;
    } catch (_) {
      state.value = ViewState.error;
    }
  }

  Future<void> setSortOption(TripSortOption sort) async {
    final updated = currentFilter.value.copyWith(sortOption: sort);
    await applyFilter(updated);
  }

  Future<void> resetFilter() async {
    currentFilter.value = const TripFilterModel();
    await applyFilter(currentFilter.value);
  }
}
