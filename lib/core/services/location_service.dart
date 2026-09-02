import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '../storage/storage_service.dart';

/// Location service managing current selected city/location and coordinates.
class LocationService extends GetxService {
  final IStorageService _storage;

  LocationService(this._storage);

  final RxString selectedCity = 'Guwahati, Assam'.obs;
  final RxString selectedArea = 'GS Road / Christian Basti'.obs;

  final List<String> availableCities = [
    'Guwahati, Assam',
    'Shillong, Meghalaya',
    'Goa, India',
    'Manali, Himachal Pradesh',
    'Jaipur, Rajasthan',
    'Bengaluru, Karnataka',
    'Delhi NCR',
  ];

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
}
