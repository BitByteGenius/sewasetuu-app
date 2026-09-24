import 'package:sewasetu/modules/stay/bookings/models/booking_model.dart';

/// Clean domain repository contract for Booking operations
abstract class IBookingRepository {
  /// Fetches user's stay reservations
  Future<List<BookingModel>> getBookings({String? status});

  /// Fetches single booking by ID
  Future<BookingModel> getBookingById(String id);

  /// Creates a new stay booking reservation
  Future<BookingModel> createBooking(BookingModel booking);

  /// Calculates pricing quotation for stay booking
  Future<Map<String, dynamic>> calculatePrice(Map<String, dynamic> payload);

  /// Cancels an existing stay booking
  Future<bool> cancelBooking(String id);
}
