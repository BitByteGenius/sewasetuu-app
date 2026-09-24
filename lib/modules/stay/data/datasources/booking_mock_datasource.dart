import 'dart:async';
import 'package:sewasetu/modules/stay/bookings/models/booking_model.dart';
import 'package:sewasetu/shared/enums/booking_status.dart';

/// Contract for Booking Mock Data Source
abstract class IBookingMockDataSource {
  Future<List<BookingModel>> fetchBookings({String? status});
  Future<BookingModel> fetchBookingById(String id);
  Future<BookingModel> addBooking(BookingModel booking);
  Future<bool> cancelBooking(String id);
}

/// Standalone Mock Data Source for Bookings
class BookingMockDataSourceImpl implements IBookingMockDataSource {
  final List<BookingModel> _bookings = [];

  BookingMockDataSourceImpl() {
    _initMockBookings();
  }

  void _initMockBookings() {
    final now = DateTime.now();

    _bookings.addAll([
      BookingModel(
        id: 'b-101',
        bookingCode: '#SS-72914',
        stayId: 'stay-1',
        stayTitle: 'The Grand Heritage Villa & Homestay',
        stayCity: 'Shillong, Meghalaya',
        stayAddress: 'Laitumkhrah, Upper Shillong',
        stayImageUrl:
            'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=600&q=80',
        roomTitle: '2 BHK Private Villa (Up to 4 Guests)',
        checkInDate: now.add(const Duration(days: 3)),
        checkOutDate: now.add(const Duration(days: 6)),
        nightsCount: 3,
        guestsCount: 2,
        nightlyRate: 3200,
        cleaningFee: 250,
        serviceFee: 180,
        taxes: 1150,
        totalAmount: 11180,
        status: BookingStatus.confirmed,
        hostName: 'Marilyn Lyngdoh',
        hostPhone: '+91 98765 43210',
      ),
      BookingModel(
        id: 'b-102',
        bookingCode: '#SS-61029',
        stayId: 'stay-2',
        stayTitle: 'Green Nest Luxury Boys & Girls PG',
        stayCity: 'Guwahati, Assam',
        stayAddress: 'Zoo Road, Near Commerce College',
        stayImageUrl:
            'https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?auto=format&fit=crop&w=600&q=80',
        roomTitle: 'Single Room with Balcony',
        checkInDate: now.subtract(const Duration(days: 20)),
        checkOutDate: now.subtract(const Duration(days: 15)),
        nightsCount: 5,
        guestsCount: 1,
        nightlyRate: 650,
        totalAmount: 3680,
        status: BookingStatus.completed,
        hostName: 'Bhaben Kalita',
        hostPhone: '+91 98765 12345',
      ),
      BookingModel(
        id: 'b-103',
        bookingCode: '#SS-49201',
        stayId: 'stay-5',
        stayTitle: 'Azure Bay Luxury Beach Resort',
        stayCity: 'Goa, India',
        stayAddress: 'Calangute - Baga Road',
        stayImageUrl:
            'https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=600&q=80',
        roomTitle: 'Deluxe Sea View Suite',
        checkInDate: now.subtract(const Duration(days: 45)),
        checkOutDate: now.subtract(const Duration(days: 42)),
        nightsCount: 3,
        guestsCount: 2,
        nightlyRate: 6500,
        totalAmount: 21850,
        status: BookingStatus.cancelled,
        hostName: 'Azure Hospitality Group',
        hostPhone: '+91 98765 67890',
      ),
    ]);
  }

  @override
  Future<List<BookingModel>> fetchBookings({String? status}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (status != null && status.isNotEmpty) {
      return _bookings.where((b) => b.status.name == status).toList();
    }
    return List.from(_bookings);
  }

  @override
  Future<BookingModel> fetchBookingById(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return _bookings.firstWhere(
      (b) => b.id == id,
      orElse: () => _bookings.first,
    );
  }

  @override
  Future<BookingModel> addBooking(BookingModel booking) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _bookings.insert(0, booking);
    return booking;
  }

  @override
  Future<bool> cancelBooking(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index = _bookings.indexWhere((b) => b.id == id);
    if (index != -1) {
      _bookings[index] = _bookings[index].copyWith(status: BookingStatus.cancelled);
      return true;
    }
    return false;
  }
}
