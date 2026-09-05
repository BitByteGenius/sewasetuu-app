import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/rental_search_model.dart';
import '../models/vehicle_model.dart';
import 'rental_city_controller.dart';

/// Controller managing the vehicle search parameters, date/time pickers, and validation.
class RentalSearchController extends GetxController {
  final RentalCityController cityController;

  RentalSearchController({required this.cityController});

  late Rx<RentalSearchModel> searchModel;

  final Rx<DateTime> pickupDate = Rx<DateTime>(
    DateTime.now().add(const Duration(days: 1)),
  );
  final Rx<TimeOfDay> pickupTime = Rx<TimeOfDay>(const TimeOfDay(hour: 10, minute: 0));

  final Rx<DateTime> returnDate = Rx<DateTime>(
    DateTime.now().add(const Duration(days: 2)),
  );
  final Rx<TimeOfDay> returnTime = Rx<TimeOfDay>(const TimeOfDay(hour: 10, minute: 0));

  final RxString pickupLocation = 'City Center Hub'.obs;
  final RxString dropoffLocation = 'City Center Hub'.obs;
  final RxBool isSameDropoff = true.obs;
  final Rx<RentalVehicleType> selectedVehicleType = RentalVehicleType.all.obs;

  @override
  void onInit() {
    super.onInit();
    _initSearchModel();

    // Keep city synchronized with cityController
    ever(cityController.selectedCity, (city) {
      if (city != null) {
        searchModel.value = searchModel.value.copyWith(
          cityId: city.id,
          cityName: city.name,
        );
      }
    });
  }

  void _initSearchModel() {
    final city = cityController.selectedCity.value;
    final pDateTime = _combineDateTime(pickupDate.value, pickupTime.value);
    final rDateTime = _combineDateTime(returnDate.value, returnTime.value);

    searchModel = RentalSearchModel(
      cityId: city?.id ?? 'guwahati',
      cityName: city?.name ?? 'Guwahati',
      pickupDateTime: pDateTime,
      returnDateTime: rDateTime,
      pickupLocation: pickupLocation.value,
      dropoffLocation: dropoffLocation.value,
      isSameDropoff: isSameDropoff.value,
      vehicleType: selectedVehicleType.value,
    ).obs;
  }

  DateTime _combineDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  void updatePickupDateTime(DateTime date, TimeOfDay time) {
    pickupDate.value = date;
    pickupTime.value = time;
    final combinedPickup = _combineDateTime(date, time);

    // Ensure return is after pickup
    if (!returnDateTime.isAfter(combinedPickup)) {
      returnDate.value = date.add(const Duration(days: 1));
      returnTime.value = time;
    }

    _syncModel();
  }

  void updateReturnDateTime(DateTime date, TimeOfDay time) {
    returnDate.value = date;
    returnTime.value = time;
    _syncModel();
  }

  void setVehicleType(RentalVehicleType type) {
    selectedVehicleType.value = type;
    _syncModel();
  }

  void toggleSameDropoff(bool value) {
    isSameDropoff.value = value;
    if (value) {
      dropoffLocation.value = pickupLocation.value;
    }
    _syncModel();
  }

  void updatePickupLocation(String loc) {
    pickupLocation.value = loc;
    if (isSameDropoff.value) {
      dropoffLocation.value = loc;
    }
    _syncModel();
  }

  void updateDropoffLocation(String loc) {
    dropoffLocation.value = loc;
    _syncModel();
  }

  void _syncModel() {
    final city = cityController.selectedCity.value;
    searchModel.value = searchModel.value.copyWith(
      cityId: city?.id ?? '',
      cityName: city?.name ?? '',
      pickupDateTime: pickupDateTime,
      returnDateTime: returnDateTime,
      pickupLocation: pickupLocation.value,
      dropoffLocation: dropoffLocation.value,
      isSameDropoff: isSameDropoff.value,
      vehicleType: selectedVehicleType.value,
    );
  }

  DateTime get pickupDateTime => _combineDateTime(pickupDate.value, pickupTime.value);
  DateTime get returnDateTime => _combineDateTime(returnDate.value, returnTime.value);

  String get formattedPickup =>
      DateFormat('dd MMM, hh:mm a').format(pickupDateTime);

  String get formattedReturn =>
      DateFormat('dd MMM, hh:mm a').format(returnDateTime);

  String get durationString {
    final days = searchModel.value.durationDays;
    return '$days ${days == 1 ? "day" : "days"} (${searchModel.value.durationHours} hrs)';
  }

  bool validateSearch() {
    final error = searchModel.value.validationError;
    if (error != null) {
      Get.snackbar(
        'Invalid Search Criteria',
        error,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withAlpha((255 * 0.9).round()),
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }
}
