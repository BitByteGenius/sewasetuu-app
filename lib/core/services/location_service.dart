import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '../storage/storage_service.dart';

/// Representation of a human-readable location item
class LocationItem {
  final String title; // Area / Locality / Landmark (e.g. "Kamakhya Gate", "Christian Basti")
  final String subtitle; // City, State, Country (e.g. "Guwahati, Assam, India")
  final double? latitude;
  final double? longitude;
  final String? placeId;

  LocationItem({
    required this.title,
    required this.subtitle,
    this.latitude,
    this.longitude,
    this.placeId,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'latitude': latitude,
        'longitude': longitude,
        'placeId': placeId,
      };

  factory LocationItem.fromJson(Map<String, dynamic> json) => LocationItem(
        title: json['title'] ?? '',
        subtitle: json['subtitle'] ?? '',
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
        placeId: json['placeId']?.toString(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationItem &&
          runtimeType == other.runtimeType &&
          title.toLowerCase() == other.title.toLowerCase() &&
          subtitle.toLowerCase() == other.subtitle.toLowerCase();

  @override
  int get hashCode => title.toLowerCase().hashCode ^ subtitle.toLowerCase().hashCode;
}

/// Location service managing real-time GPS detection, Leaflet/OSM search,
/// human-readable address formatting, and recently searched locations.
class LocationService extends GetxService {
  final IStorageService _storage;
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 6),
      receiveTimeout: const Duration(seconds: 6),
      headers: {
        'User-Agent': 'SewaSetuApp/1.0 (contact@sewasetu.com)',
        'Accept': 'application/json',
      },
    ),
  );

  LocationService([IStorageService? storage])
      : _storage = storage ??
            (Get.isRegistered<IStorageService>()
                ? Get.find<IStorageService>()
                : StorageService());

  final RxString selectedCity = 'Guwahati, Assam, India'.obs;
  final RxString selectedArea = 'Kamakhya Gate'.obs;
  final Rx<double?> selectedLat = Rx<double?>(26.1557);
  final Rx<double?> selectedLng = Rx<double?>(91.7088);

  final RxBool isLocating = false.obs;
  final RxBool isSearching = false.obs;
  final RxList<LocationItem> recentLocations = <LocationItem>[].obs;
  final RxList<LocationItem> searchResults = <LocationItem>[].obs;

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
    _loadSavedLocation();
    _loadRecentLocations();
  }

  void _loadSavedLocation() {
    final savedCity = _storage.getString(AppConstants.selectedCityKey);
    final savedArea = _storage.getString(AppConstants.selectedAreaKey);
    final savedLat = _storage.getString(AppConstants.selectedLatKey);
    final savedLng = _storage.getString(AppConstants.selectedLngKey);

    if (savedCity != null && savedCity.isNotEmpty) {
      selectedCity.value = savedCity;
    }
    if (savedArea != null && savedArea.isNotEmpty) {
      selectedArea.value = savedArea;
    }
    if (savedLat != null) {
      selectedLat.value = double.tryParse(savedLat);
    }
    if (savedLng != null) {
      selectedLng.value = double.tryParse(savedLng);
    }
  }

  void _loadRecentLocations() {
    final recentsJson = _storage.getString(AppConstants.recentLocationsKey);
    if (recentsJson != null && recentsJson.isNotEmpty) {
      try {
        final List<dynamic> decoded = jsonDecode(recentsJson);
        final items = decoded.map((e) => LocationItem.fromJson(e)).toList();
        recentLocations.assignAll(items);
      } catch (_) {}
    }

    // Default recents if empty
    if (recentLocations.isEmpty) {
      recentLocations.addAll([
        LocationItem(
          title: 'Kamakhya Gate',
          subtitle: 'Fatashil Hills, Guwahati, Assam, India',
          latitude: 26.1557,
          longitude: 91.7088,
        ),
        LocationItem(
          title: 'Christian Basti',
          subtitle: 'GS Road, Guwahati, Assam, India',
          latitude: 26.1508,
          longitude: 91.7770,
        ),
        LocationItem(
          title: 'Police Bazar',
          subtitle: 'Shillong, Meghalaya, India',
          latitude: 25.5788,
          longitude: 91.8833,
        ),
      ]);
      _saveRecentLocations();
    }
  }

  void _saveRecentLocations() {
    final encoded = jsonEncode(recentLocations.map((e) => e.toJson()).toList());
    _storage.setString(AppConstants.recentLocationsKey, encoded);
  }

  /// Automatically requests permission and detects current location at startup
  Future<void> initAutoLocation() async {
    try {
      isLocating.value = true;
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        isLocating.value = false;
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          isLocating.value = false;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        isLocating.value = false;
        return;
      }

      // Fetch position
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      await reverseGeocodePosition(position.latitude, position.longitude);
    } catch (_) {
      // Fallback gracefully without interrupting user experience
    } finally {
      isLocating.value = false;
    }
  }

  /// Explicitly triggered by "Use Current Location" button with full permission handling & user guidance
  Future<bool> useCurrentGpsLocation() async {
    try {
      isLocating.value = true;

      // 1. Check if device location service (GPS toggle) is enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        isLocating.value = false;
        Get.snackbar(
          'Location Services Disabled',
          'Please turn on GPS / Location on your device to detect your location.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF1E293B),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          icon: const Icon(Icons.location_off_rounded, color: Color(0xFFEF4444)),
          mainButton: TextButton(
            onPressed: () => Geolocator.openLocationSettings(),
            child: const Text(
              'ENABLE',
              style: TextStyle(color: Color(0xFF14B8A6), fontWeight: FontWeight.bold),
            ),
          ),
        );
        return false;
      }

      // 2. Check & Request Location Permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          isLocating.value = false;
          Get.snackbar(
            'Permission Denied',
            'Location permission is required to automatically detect your current address.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF1E293B),
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
            margin: const EdgeInsets.all(16),
            borderRadius: 12,
            icon: const Icon(Icons.security_rounded, color: Color(0xFFF59E0B)),
          );
          return false;
        }
      }

      // 3. Handle Permanently Denied
      if (permission == LocationPermission.deniedForever) {
        isLocating.value = false;
        Get.snackbar(
          'Location Permission Blocked',
          'Location permission was permanently denied. Please enable it in Settings.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF1E293B),
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          icon: const Icon(Icons.settings_rounded, color: Color(0xFFEF4444)),
          mainButton: TextButton(
            onPressed: () => Geolocator.openAppSettings(),
            child: const Text(
              'SETTINGS',
              style: TextStyle(color: Color(0xFF14B8A6), fontWeight: FontWeight.bold),
            ),
          ),
        );
        return false;
      }

      // 4. Permission is granted - fetch GPS position
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 12),
        ),
      );

      // 5. Reverse geocode position with Leaflet / OpenStreetMap Nominatim
      await reverseGeocodePosition(position.latitude, position.longitude);

      Get.snackbar(
        'Location Updated',
        'Updated to ${selectedArea.value}, ${selectedCity.value}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF1E293B),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981)),
      );

      return true;
    } catch (e) {
      Get.snackbar(
        'Location Error',
        'Could not determine GPS location. Please try searching for your area.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF1E293B),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.error_outline_rounded, color: Color(0xFFEF4444)),
      );
      return false;
    } finally {
      isLocating.value = false;
    }
  }

  /// Leaflet / OpenStreetMap Reverse Geocoding via Nominatim
  Future<void> reverseGeocodePosition(double lat, double lng) async {
    try {
      final response = await _dio.get(
        'https://nominatim.openstreetmap.org/reverse',
        queryParameters: {
          'lat': lat,
          'lon': lng,
          'format': 'json',
          'addressdetails': 1,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        final address = data['address'] as Map<String, dynamic>? ?? {};

        // Extract Human-Readable Area / Landmark
        final area = address['suburb'] ??
            address['neighbourhood'] ??
            address['residential'] ??
            address['quarter'] ??
            address['commercial'] ??
            address['road'] ??
            address['village'] ??
            address['city_district'] ??
            address['town'] ??
            'Current Location';

        // Extract City, State, Country Subtitle
        final city = address['city'] ?? address['town'] ?? address['municipality'] ?? address['county'] ?? 'Guwahati';
        final state = address['state'] ?? 'Assam';
        final country = address['country'] ?? 'India';
        final subtitle = '$city, $state, $country';

        final item = LocationItem(
          title: area.toString(),
          subtitle: subtitle,
          latitude: lat,
          longitude: lng,
          placeId: data['place_id']?.toString(),
        );

        selectLocationItem(item);
      }
    } catch (_) {
      // Fallback
      final item = LocationItem(
        title: 'Current Location (GPS)',
        subtitle: 'Guwahati, Assam, India',
        latitude: lat,
        longitude: lng,
      );
      selectLocationItem(item);
    }
  }

  /// Leaflet / OpenStreetMap Search API integration (Nominatim + Photon fallback)
  Future<List<LocationItem>> searchLocations(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      searchResults.clear();
      return [];
    }

    try {
      isSearching.value = true;

      // 1. Query OpenStreetMap Nominatim API
      final response = await _dio.get(
        'https://nominatim.openstreetmap.org/search',
        queryParameters: {
          'q': trimmed,
          'format': 'json',
          'addressdetails': 1,
          'limit': 8,
        },
      );

      if (response.statusCode == 200 && response.data is List) {
        final list = response.data as List;
        final items = list.map((item) {
          final addr = item['address'] as Map<String, dynamic>? ?? {};
          final name = item['name'] ?? '';
          final suburb = addr['suburb'] ?? addr['neighbourhood'] ?? addr['quarter'] ?? addr['road'];
          final city = addr['city'] ?? addr['town'] ?? addr['village'] ?? addr['county'] ?? '';
          final state = addr['state'] ?? '';
          final country = addr['country'] ?? '';

          final title = name.isNotEmpty ? name : (suburb ?? city ?? trimmed);

          final subParts = <String>[];
          if (suburb != null && suburb != title) subParts.add(suburb);
          if (city.isNotEmpty && city != title) subParts.add(city);
          if (state.isNotEmpty) subParts.add(state);
          if (country.isNotEmpty) subParts.add(country);
          final subtitle = subParts.isNotEmpty ? subParts.join(', ') : item['display_name'] ?? '';

          return LocationItem(
            title: title.toString(),
            subtitle: subtitle,
            latitude: double.tryParse(item['lat']?.toString() ?? ''),
            longitude: double.tryParse(item['lon']?.toString() ?? ''),
            placeId: item['place_id']?.toString(),
          );
        }).toList();

        searchResults.assignAll(items);
        return items;
      }
    } catch (_) {
      // 2. Fallback to Photon OpenStreetMap Geocoder
      try {
        final photonResponse = await _dio.get(
          'https://photon.komoot.io/api/',
          queryParameters: {'q': trimmed, 'limit': 8},
        );
        if (photonResponse.statusCode == 200 && photonResponse.data != null) {
          final features = photonResponse.data['features'] as List? ?? [];
          final items = features.map((f) {
            final props = f['properties'] as Map<String, dynamic>? ?? {};
            final geometry = f['geometry'] as Map<String, dynamic>? ?? {};
            final coords = geometry['coordinates'] as List? ?? [];

            final title = props['name'] ?? trimmed;
            final city = props['city'] ?? props['district'] ?? '';
            final state = props['state'] ?? '';
            final country = props['country'] ?? '';
            final subtitle = [city, state, country].where((s) => s.isNotEmpty).join(', ');

            return LocationItem(
              title: title.toString(),
              subtitle: subtitle.isNotEmpty ? subtitle : 'India',
              longitude: coords.isNotEmpty ? (coords[0] as num).toDouble() : null,
              latitude: coords.length > 1 ? (coords[1] as num).toDouble() : null,
            );
          }).toList();

          searchResults.assignAll(items);
          return items;
        }
      } catch (_) {}
    } finally {
      isSearching.value = false;
    }

    return [];
  }

  /// Sets location from an item and tracks it in recent searches
  void selectLocationItem(LocationItem item) {
    selectedArea.value = item.title;
    selectedCity.value = item.subtitle;
    if (item.latitude != null) selectedLat.value = item.latitude;
    if (item.longitude != null) selectedLng.value = item.longitude;

    _storage.setString(AppConstants.selectedAreaKey, item.title);
    _storage.setString(AppConstants.selectedCityKey, item.subtitle);
    if (item.latitude != null) {
      _storage.setString(AppConstants.selectedLatKey, item.latitude.toString());
    }
    if (item.longitude != null) {
      _storage.setString(AppConstants.selectedLngKey, item.longitude.toString());
    }

    addRecentLocation(item);
  }

  /// Adds an item to the recently searched list (max 8, deduplicated)
  void addRecentLocation(LocationItem item) {
    recentLocations.removeWhere((e) => e == item);
    recentLocations.insert(0, item);
    if (recentLocations.length > 8) {
      recentLocations.assignAll(recentLocations.take(8));
    }
    _saveRecentLocations();
  }

  /// Clears recent location history
  void clearRecentLocations() {
    recentLocations.clear();
    _storage.remove(AppConstants.recentLocationsKey);
  }

  void updateCity(String city, [String? area]) {
    final item = LocationItem(
      title: area ?? city.split(',').first.trim(),
      subtitle: city,
    );
    selectLocationItem(item);
  }

  void setCity(String city, [String? area]) => updateCity(city, area);
}
