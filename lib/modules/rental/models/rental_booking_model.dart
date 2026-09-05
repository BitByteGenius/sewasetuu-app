import 'rental_addon_model.dart';
import 'rental_pricing_model.dart';
import 'vehicle_model.dart';

/// Status of a rental booking throughout its lifecycle.
enum RentalBookingStatus {
  draft,
  pending,
  paymentPending,
  confirmed,
  active,
  completed,
  cancelled,
}

extension RentalBookingStatusExtension on RentalBookingStatus {
  String get label {
    switch (this) {
      case RentalBookingStatus.draft:
        return 'Draft';
      case RentalBookingStatus.pending:
        return 'Pending';
      case RentalBookingStatus.paymentPending:
        return 'Payment Pending';
      case RentalBookingStatus.confirmed:
        return 'Confirmed';
      case RentalBookingStatus.active:
        return 'Active Ride';
      case RentalBookingStatus.completed:
        return 'Completed';
      case RentalBookingStatus.cancelled:
        return 'Cancelled';
    }
  }
}

/// Comprehensive model for vehicle rental reservations.
class RentalBookingModel {
  final String id;
  final String bookingNumber;
  final String userId;
  final String vehicleId;
  final VehicleModel? vehicle;
  final String cityId;
  final String cityName;
  final DateTime pickupDateTime;
  final DateTime returnDateTime;
  final String pickupLocation;
  final String returnLocation;
  final bool isDoorstepDelivery;
  final List<RentalAddonModel> selectedAddons;
  final RentalPricingModel pricing;
  final RentalBookingStatus status;
  final String paymentStatus; // 'unpaid', 'paid', 'refunded'
  final String driverName;
  final String driverPhone;
  final String driverLicenseNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  RentalBookingModel({
    required this.id,
    required this.bookingNumber,
    this.userId = 'usr_guest_01',
    required this.vehicleId,
    this.vehicle,
    required this.cityId,
    required this.cityName,
    required this.pickupDateTime,
    required this.returnDateTime,
    this.pickupLocation = 'City Hub',
    this.returnLocation = 'City Hub',
    this.isDoorstepDelivery = false,
    this.selectedAddons = const [],
    required this.pricing,
    this.status = RentalBookingStatus.confirmed,
    this.paymentStatus = 'paid',
    this.driverName = 'SewaSetu Traveler',
    this.driverPhone = '+91 98765 43210',
    this.driverLicenseNumber = 'AS01 20230048123',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  int get durationDays => pricing.durationDays;

  RentalBookingModel copyWith({
    String? id,
    String? bookingNumber,
    String? userId,
    String? vehicleId,
    VehicleModel? vehicle,
    String? cityId,
    String? cityName,
    DateTime? pickupDateTime,
    DateTime? returnDateTime,
    String? pickupLocation,
    String? returnLocation,
    bool? isDoorstepDelivery,
    List<RentalAddonModel>? selectedAddons,
    RentalPricingModel? pricing,
    RentalBookingStatus? status,
    String? paymentStatus,
    String? driverName,
    String? driverPhone,
    String? driverLicenseNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RentalBookingModel(
      id: id ?? this.id,
      bookingNumber: bookingNumber ?? this.bookingNumber,
      userId: userId ?? this.userId,
      vehicleId: vehicleId ?? this.vehicleId,
      vehicle: vehicle ?? this.vehicle,
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
      pickupDateTime: pickupDateTime ?? this.pickupDateTime,
      returnDateTime: returnDateTime ?? this.returnDateTime,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      returnLocation: returnLocation ?? this.returnLocation,
      isDoorstepDelivery: isDoorstepDelivery ?? this.isDoorstepDelivery,
      selectedAddons: selectedAddons ?? this.selectedAddons,
      pricing: pricing ?? this.pricing,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      driverName: driverName ?? this.driverName,
      driverPhone: driverPhone ?? this.driverPhone,
      driverLicenseNumber: driverLicenseNumber ?? this.driverLicenseNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory RentalBookingModel.fromJson(Map<String, dynamic> json) {
    RentalBookingStatus bStatus = RentalBookingStatus.confirmed;
    final statusStr = json['status'] as String?;
    if (statusStr != null) {
      bStatus = RentalBookingStatus.values.firstWhere(
        (e) => e.name.toLowerCase() == statusStr.toLowerCase(),
        orElse: () => RentalBookingStatus.confirmed,
      );
    }

    return RentalBookingModel(
      id: json['id'] as String? ?? '',
      bookingNumber: json['bookingNumber'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      vehicleId: json['vehicleId'] as String? ?? '',
      vehicle: json['vehicle'] != null
          ? VehicleModel.fromJson(json['vehicle'] as Map<String, dynamic>)
          : null,
      cityId: json['cityId'] as String? ?? '',
      cityName: json['cityName'] as String? ?? '',
      pickupDateTime: json['pickupDateTime'] != null
          ? DateTime.tryParse(json['pickupDateTime'] as String) ?? DateTime.now()
          : DateTime.now(),
      returnDateTime: json['returnDateTime'] != null
          ? DateTime.tryParse(json['returnDateTime'] as String) ?? DateTime.now()
          : DateTime.now(),
      pickupLocation: json['pickupLocation'] as String? ?? 'City Hub',
      returnLocation: json['returnLocation'] as String? ?? 'City Hub',
      isDoorstepDelivery: json['isDoorstepDelivery'] as bool? ?? false,
      selectedAddons: (json['selectedAddons'] as List<dynamic>?)
              ?.map((e) => RentalAddonModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      pricing: json['pricing'] != null
          ? RentalPricingModel.fromJson(json['pricing'] as Map<String, dynamic>)
          : RentalPricingModel.calculate(basePricePerDay: 0, durationDays: 1),
      status: bStatus,
      paymentStatus: json['paymentStatus'] as String? ?? 'paid',
      driverName: json['driverName'] as String? ?? '',
      driverPhone: json['driverPhone'] as String? ?? '',
      driverLicenseNumber: json['driverLicenseNumber'] as String? ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingNumber': bookingNumber,
      'userId': userId,
      'vehicleId': vehicleId,
      'vehicle': vehicle?.toJson(),
      'cityId': cityId,
      'cityName': cityName,
      'pickupDateTime': pickupDateTime.toIso8601String(),
      'returnDateTime': returnDateTime.toIso8601String(),
      'pickupLocation': pickupLocation,
      'returnLocation': returnLocation,
      'isDoorstepDelivery': isDoorstepDelivery,
      'selectedAddons': selectedAddons.map((e) => e.toJson()).toList(),
      'pricing': pricing.toJson(),
      'status': status.name,
      'paymentStatus': paymentStatus,
      'driverName': driverName,
      'driverPhone': driverPhone,
      'driverLicenseNumber': driverLicenseNumber,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
