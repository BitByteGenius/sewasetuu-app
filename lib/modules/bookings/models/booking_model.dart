import 'package:sewasetu/shared/enums/booking_status.dart';

enum PaymentMethodType {
  upi('UPI (Google Pay, PhonePe, Paytm)', 'Instant & Zero Convenience Fee', '⚡'),
  card('Credit / Debit Card', 'Visa, MasterCard, RuPay', '💳'),
  netBanking('Net Banking', 'All Major Indian Banks', '🏦'),
  payAtProperty('Pay at Check-in', 'Cash or UPI upon arrival', '💵');

  final String title;
  final String subtitle;
  final String icon;

  const PaymentMethodType(this.title, this.subtitle, this.icon);
}

/// Model representing a Stay reservation / booking
class BookingModel {
  final String id;
  final String bookingCode;
  final String stayId;
  final String stayTitle;
  final String stayCity;
  final String stayAddress;
  final String stayImageUrl;
  final String roomTitle;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int nightsCount;
  final int guestsCount;
  final double nightlyRate;
  final double cleaningFee;
  final double serviceFee;
  final double taxes;
  final double discount;
  final double totalAmount;
  final BookingStatus status;
  final PaymentMethodType paymentMethod;
  final bool isPaid;
  final String hostName;
  final String hostPhone;

  const BookingModel({
    required this.id,
    required this.bookingCode,
    required this.stayId,
    required this.stayTitle,
    required this.stayCity,
    required this.stayAddress,
    required this.stayImageUrl,
    required this.roomTitle,
    required this.checkInDate,
    required this.checkOutDate,
    required this.nightsCount,
    required this.guestsCount,
    required this.nightlyRate,
    this.cleaningFee = 250,
    this.serviceFee = 180,
    this.taxes = 320,
    this.discount = 0,
    required this.totalAmount,
    this.status = BookingStatus.confirmed,
    this.paymentMethod = PaymentMethodType.upi,
    this.isPaid = true,
    required this.hostName,
    required this.hostPhone,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String? ?? '',
      bookingCode: json['booking_code'] as String? ?? '',
      stayId: json['stay_id'] as String? ?? '',
      stayTitle: json['stay_title'] as String? ?? '',
      stayCity: json['stay_city'] as String? ?? '',
      stayAddress: json['stay_address'] as String? ?? '',
      stayImageUrl: json['stay_image_url'] as String? ?? '',
      roomTitle: json['room_title'] as String? ?? '',
      checkInDate: DateTime.tryParse(json['check_in_date'] as String? ?? '') ?? DateTime.now(),
      checkOutDate: DateTime.tryParse(json['check_out_date'] as String? ?? '') ?? DateTime.now().add(const Duration(days: 1)),
      nightsCount: json['nights_count'] as int? ?? 1,
      guestsCount: json['guests_count'] as int? ?? 1,
      nightlyRate: (json['nightly_rate'] as num?)?.toDouble() ?? 0.0,
      cleaningFee: (json['cleaning_fee'] as num?)?.toDouble() ?? 250.0,
      serviceFee: (json['service_fee'] as num?)?.toDouble() ?? 180.0,
      taxes: (json['taxes'] as num?)?.toDouble() ?? 320.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      status: BookingStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => BookingStatus.confirmed,
      ),
      paymentMethod: PaymentMethodType.values.firstWhere(
        (e) => e.name == json['payment_method'],
        orElse: () => PaymentMethodType.upi,
      ),
      isPaid: json['is_paid'] as bool? ?? true,
      hostName: json['host_name'] as String? ?? '',
      hostPhone: json['host_phone'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'booking_code': bookingCode,
        'stay_id': stayId,
        'stay_title': stayTitle,
        'stay_city': stayCity,
        'stay_address': stayAddress,
        'stay_image_url': stayImageUrl,
        'room_title': roomTitle,
        'check_in_date': checkInDate.toIso8601String(),
        'check_out_date': checkOutDate.toIso8601String(),
        'nights_count': nightsCount,
        'guests_count': guestsCount,
        'nightly_rate': nightlyRate,
        'cleaning_fee': cleaningFee,
        'service_fee': serviceFee,
        'taxes': taxes,
        'discount': discount,
        'total_amount': totalAmount,
        'status': status.name,
        'payment_method': paymentMethod.name,
        'is_paid': isPaid,
        'host_name': hostName,
        'host_phone': hostPhone,
      };

  BookingModel copyWith({
    String? id,
    String? bookingCode,
    String? stayId,
    String? stayTitle,
    String? stayCity,
    String? stayAddress,
    String? stayImageUrl,
    String? roomTitle,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? nightsCount,
    int? guestsCount,
    double? nightlyRate,
    double? cleaningFee,
    double? serviceFee,
    double? taxes,
    double? discount,
    double? totalAmount,
    BookingStatus? status,
    PaymentMethodType? paymentMethod,
    bool? isPaid,
    String? hostName,
    String? hostPhone,
  }) {
    return BookingModel(
      id: id ?? this.id,
      bookingCode: bookingCode ?? this.bookingCode,
      stayId: stayId ?? this.stayId,
      stayTitle: stayTitle ?? this.stayTitle,
      stayCity: stayCity ?? this.stayCity,
      stayAddress: stayAddress ?? this.stayAddress,
      stayImageUrl: stayImageUrl ?? this.stayImageUrl,
      roomTitle: roomTitle ?? this.roomTitle,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      nightsCount: nightsCount ?? this.nightsCount,
      guestsCount: guestsCount ?? this.guestsCount,
      nightlyRate: nightlyRate ?? this.nightlyRate,
      cleaningFee: cleaningFee ?? this.cleaningFee,
      serviceFee: serviceFee ?? this.serviceFee,
      taxes: taxes ?? this.taxes,
      discount: discount ?? this.discount,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isPaid: isPaid ?? this.isPaid,
      hostName: hostName ?? this.hostName,
      hostPhone: hostPhone ?? this.hostPhone,
    );
  }
}

typedef BookingReservationEntity = BookingModel;
