import 'package:get/get.dart';
import '../data/repositories/rental_repository.dart';
import '../models/rental_city_model.dart';

/// Controller managing city selection, launch availability, and city-search filtering.
class RentalCityController extends GetxController {
  final RentalRepository repository;

  RentalCityController({required this.repository});

  final RxBool isLoading = true.obs;
  final RxList<RentalCityModel> allCities = <RentalCityModel>[].obs;
  final Rx<RentalCityModel?> selectedCity = Rx<RentalCityModel?>(null);
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadCities();
  }

  /// Loads cities from the repository and sets the initial default city.
  Future<void> loadCities() async {
    try {
      isLoading.value = true;
      final cities = await repository.getCities();
      allCities.assignAll(cities);

      // Default to first available city (Guwahati) if not set
      if (selectedCity.value == null) {
        final defaultCity = cities.firstWhere(
          (c) => c.isLive,
          orElse: () => cities.first,
        );
        selectedCity.value = defaultCity;
      }
    } catch (e) {
      Get.snackbar(
        'Cities Unavailable',
        'Could not load cities. Please check connection.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Available cities ready for immediate rental bookings.
  List<RentalCityModel> get availableCities {
    final query = searchQuery.value.trim().toLowerCase();
    return allCities.where((c) {
      final matchesQuery = query.isEmpty ||
          c.name.toLowerCase().contains(query) ||
          c.state.toLowerCase().contains(query);
      return c.isLive && matchesQuery;
    }).toList();
  }

  /// Cities scheduled for upcoming expansion phases.
  List<RentalCityModel> get comingSoonCities {
    final query = searchQuery.value.trim().toLowerCase();
    return allCities.where((c) {
      final matchesQuery = query.isEmpty ||
          c.name.toLowerCase().contains(query) ||
          c.state.toLowerCase().contains(query);
      return c.isComingSoon && matchesQuery;
    }).toList();
  }

  /// Updates city search text query.
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  /// Attempts to select a city. Prevents booking in coming-soon cities.
  bool selectCity(RentalCityModel city) {
    if (city.isComingSoon) {
      Get.snackbar(
        'Coming Soon to ${city.name}!',
        'We are currently preparing vehicles in ${city.name}. Launching very soon in Phase 2.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      return false;
    }

    if (!city.isLive) {
      Get.snackbar(
        'City Temporarily Unavailable',
        'Rental service is currently not active in ${city.name}.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    selectedCity.value = city;
    return true;
  }
}
