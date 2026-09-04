import 'package:get/get.dart';
import '../../../../shared/enums/view_state.dart';
import '../data/repositories/trips_repository.dart';
import '../data/repositories/trips_repository_impl.dart';
import '../models/destination_model.dart';
import '../models/trip_package_model.dart';
import '../models/trip_theme_model.dart';

/// Controller powering the main travel & trips discovery screen
class TripsController extends GetxController {
  final TripsRepository repository;

  TripsController({TripsRepository? repository})
      : repository = repository ?? TripsRepositoryImpl();

  final Rx<ViewState> state = ViewState.initial.obs;

  final RxList<DestinationModel> featuredDestinations =
      <DestinationModel>[].obs;
  final RxList<DestinationModel> allDestinations = <DestinationModel>[].obs;
  final RxList<TripPackageModel> featuredPackages = <TripPackageModel>[].obs;
  final RxList<TripPackageModel> popularPackages = <TripPackageModel>[].obs;
  final RxList<TripThemeModel> themes = <TripThemeModel>[].obs;

  final Rxn<TripThemeModel> selectedTheme = Rxn<TripThemeModel>();
  final RxList<TripPackageModel> themeFilteredPackages =
      <TripPackageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTripsFeed();
  }

  Future<void> loadTripsFeed() async {
    try {
      state.value = ViewState.loading;

      final results = await Future.wait([
        repository.getFeaturedDestinations(),
        repository.getAllDestinations(),
        repository.getFeaturedPackages(),
        repository.getPopularPackages(),
        repository.getThemes(),
      ]);

      featuredDestinations.assignAll(results[0] as List<DestinationModel>);
      allDestinations.assignAll(results[1] as List<DestinationModel>);
      featuredPackages.assignAll(results[2] as List<TripPackageModel>);
      popularPackages.assignAll(results[3] as List<TripPackageModel>);
      themes.assignAll(results[4] as List<TripThemeModel>);

      state.value = ViewState.loaded;
    } catch (_) {
      state.value = ViewState.error;
    }
  }

  Future<void> refreshFeed() async {
    await loadTripsFeed();
  }

  Future<void> selectTheme(TripThemeModel? theme) async {
    if (selectedTheme.value?.id == theme?.id) {
      selectedTheme.value = null;
      themeFilteredPackages.clear();
      return;
    }

    selectedTheme.value = theme;
    if (theme != null) {
      final pkgs = await repository.getPackagesByTheme(theme.id);
      themeFilteredPackages.assignAll(pkgs);
    } else {
      themeFilteredPackages.clear();
    }
  }
}
