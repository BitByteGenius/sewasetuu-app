import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '../storage/storage_service.dart';

/// Location service managing current selected city/location and coordinates.
class LocationService extends GetxService {
  final IStorageService _storage;

  LocationService([IStorageService? storage])
      : _storage = storage ?? (Get.isRegistered<IStorageService>() ? Get.find<IStorageService>() : StorageService());

  final RxString selectedCity = 'Guwahati, Assam'.obs;
  final RxString selectedArea = 'GS Road / Christian Basti'.obs;

  static const List<String> availableCities = [
    'Guwahati, Assam',
    'Shillong, Meghalaya',
    'Goa, India',
    'Manali, Himachal Pradesh',
    'Jaipur, Rajasthan',
    'Bengaluru, Karnataka',
    'Delhi NCR',
  ];

  static List<String> get popularCities => availableCities;
  List<String> get cities => availableCities;

  @override
  void onInit() {
    super.onInit();
    final savedCity = _storage.getString(AppConstants.selectedCityKey);
    if (savedCity != null && savedCity.isNotEmpty) {
      selectedCity.value = savedCity;
    }
  }

  void updateCity(String city, [String? area]) {
    selectedCity.value = city;
    if (area != null) {
      selectedArea.value = area;
    }
    _storage.setString(AppConstants.selectedCityKey, city);
  }

  void setCity(String city, [String? area]) => updateCity(city, area);

  Future<void> useCurrentGpsLocation() async {
    updateCity('Guwahati, Assam', 'Current Location (GPS)');
  }
}
