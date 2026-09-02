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

/// Domain entity representing a completed or active Stay reservation
class BookingReservationEntity {
  final String id;
  final String bookingCode; // e.g. #SS-89201
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

  const BookingReservationEntity({
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
}
