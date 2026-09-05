import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/repositories/rental_repository.dart';
import '../models/rental_addon_model.dart';
import '../models/rental_booking_model.dart';
import '../models/rental_pricing_model.dart';
import '../models/rental_search_model.dart';
import '../models/vehicle_model.dart';

/// Controller handling the end-to-end checkout, add-on selections, coupon application, and pricing.
class RentalBookingController extends GetxController {
  final RentalRepository repository;

  RentalBookingController({required this.repository});

  final RxBool isSubmitting = false.obs;
  final Rx<VehicleModel?> vehicle = Rx<VehicleModel?>(null);
  final Rx<RentalSearchModel?> searchModel = Rx<RentalSearchModel?>(null);

  // Delivery preferences
  final RxBool isDoorstepDelivery = false.obs;
  final RxString deliveryAddress = ''.obs;

  // Add-ons
  final RxList<RentalAddonModel> availableAddons = <RentalAddonModel>[].obs;
  final RxSet<String> selectedAddonIds = <String>{'addon_insurance_zero'}.obs;

  // Driver details form
  final RxString driverName = 'SewaSetu Traveler'.obs;
  final RxString driverPhone = '+91 98765 43210'.obs;
  final RxString driverLicense = 'AS01 20230048123'.obs;

  // Coupon code
  final RxString appliedCoupon = ''.obs;
  final RxDouble discountAmount = 0.0.obs;

  // Confirmed booking result
  final Rx<RentalBookingModel?> confirmedBooking = Rx<RentalBookingModel?>(null);

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      if (args['vehicle'] is VehicleModel) {
        setBookingContext(
          args['vehicle'] as VehicleModel,
          args['search'] as RentalSearchModel?,
        );
      }
    }
  }

  void setBookingContext(VehicleModel v, RentalSearchModel? s) {
    vehicle.value = v;
    searchModel.value = s ??
        RentalSearchModel(
          cityId: v.cityIds.isNotEmpty ? v.cityIds.first : 'guwahati',
          cityName: 'Guwahati',
        );

    loadAddons(v);
  }

  Future<void> loadAddons(VehicleModel v) async {
    final addons = await repository.getAddonsForVehicle(v);
    availableAddons.assignAll(addons);
  }

  void toggleAddon(RentalAddonModel addon) {
    if (selectedAddonIds.contains(addon.id)) {
      selectedAddonIds.remove(addon.id);
    } else {
      selectedAddonIds.add(addon.id);
    }
  }

  bool isAddonSelected(String addonId) {
    return selectedAddonIds.contains(addonId);
  }

  void toggleDoorstepDelivery(bool value) {
    isDoorstepDelivery.value = value;
  }

  void applyCoupon(String code) {
    final cleanCode = code.trim().toUpperCase();
    if (cleanCode == 'FIRSTDRIVE') {
      appliedCoupon.value = 'FIRSTDRIVE';
      discountAmount.value = 300.0;
      Get.snackbar(
        'Promo Applied!',
        '₹300 flat discount applied to your rental.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade700,
        colorText: Colors.white,
      );
    } else if (cleanCode == 'SEWASETU10') {
      appliedCoupon.value = 'SEWASETU10';
      final base = (vehicle.value?.pricePerDay ?? 0.0) * durationDays;
      discountAmount.value = double.parse((base * 0.10).toStringAsFixed(2));
      Get.snackbar(
        'Promo Applied!',
        '10% discount applied to base rental.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade700,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Invalid Coupon',
        'Coupon code is invalid or expired. Try "FIRSTDRIVE" or "SEWASETU10".',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void removeCoupon() {
    appliedCoupon.value = '';
    discountAmount.value = 0.0;
  }

  int get durationDays => searchModel.value?.durationDays ?? 1;

  /// Dynamic live calculation of rental costs
  RentalPricingModel get pricing {
    final v = vehicle.value;
    if (v == null) {
      return RentalPricingModel.calculate(basePricePerDay: 0, durationDays: 1);
    }

    // Sum selected addons
    double totalAddonCost = 0;
    for (final addon in availableAddons) {
      if (selectedAddonIds.contains(addon.id)) {
        totalAddonCost += addon.calculateCost(durationDays);
      }
    }

    final deliveryFee = isDoorstepDelivery.value ? 399.0 : 0.0;

    return RentalPricingModel.calculate(
      basePricePerDay: v.pricePerDay,
      durationDays: durationDays,
      durationHours: searchModel.value?.durationHours ?? 24,
      addonCost: totalAddonCost,
      deliveryFee: deliveryFee,
      discountAmount: discountAmount.value,
      couponCode: appliedCoupon.value.isNotEmpty ? appliedCoupon.value : null,
      securityDeposit: v.securityDeposit,
    );
  }

  Future<RentalBookingModel?> submitBooking() async {
    final v = vehicle.value;
    final s = searchModel.value;
    if (v == null || s == null) return null;

    try {
      isSubmitting.value = true;

      final selectedAddonList = availableAddons
          .where((a) => selectedAddonIds.contains(a.id))
          .toList();

      final bookingNumber =
          'SW-RNT-2026-${1000 + Random().nextInt(9000)}';

      final newBooking = RentalBookingModel(
        id: 'bk_${DateTime.now().millisecondsSinceEpoch}',
        bookingNumber: bookingNumber,
        vehicleId: v.id,
        vehicle: v,
        cityId: s.cityId,
        cityName: s.cityName,
        pickupDateTime: s.pickupDateTime,
        returnDateTime: s.returnDateTime,
        pickupLocation: isDoorstepDelivery.value
            ? (deliveryAddress.value.isNotEmpty ? deliveryAddress.value : 'Doorstep: Guwahati Hub')
            : s.pickupLocation,
        returnLocation: s.dropoffLocation,
        isDoorstepDelivery: isDoorstepDelivery.value,
        selectedAddons: selectedAddonList,
        pricing: pricing,
        status: RentalBookingStatus.confirmed,
        paymentStatus: 'paid',
        driverName: driverName.value,
        driverPhone: driverPhone.value,
        driverLicenseNumber: driverLicense.value,
      );

      final result = await repository.createBooking(newBooking);
      confirmedBooking.value = result;
      return result;
    } catch (e) {
      Get.snackbar(
        'Booking Failed',
        'Could not complete reservation. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } finally {
      isSubmitting.value = false;
    }
  }
}
