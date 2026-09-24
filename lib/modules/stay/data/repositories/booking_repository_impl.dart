import 'package:sewasetu/modules/stay/bookings/models/booking_model.dart';
import 'package:sewasetu/modules/stay/data/datasources/booking_mock_datasource.dart';
import 'package:sewasetu/modules/stay/data/datasources/booking_remote_datasource.dart';
import 'package:sewasetu/modules/stay/domain/repositories/booking_repository.dart';

/// Implementation of IBookingRepository managing Remote API & Mock Data fallback
class BookingRepositoryImpl implements IBookingRepository {
  final IBookingRemoteDataSource? remoteDataSource;
  final IBookingMockDataSource mockDataSource;
  final bool preferRemote;

  BookingRepositoryImpl({
    this.remoteDataSource,
    IBookingMockDataSource? mockDataSource,
    this.preferRemote = false,
  }) : mockDataSource = mockDataSource ?? BookingMockDataSourceImpl();

  @override
  Future<List<BookingModel>> getBookings({String? status}) async {
    if (preferRemote && remoteDataSource != null) {
      try {
        return await remoteDataSource!.fetchBookings(status: status);
      } catch (_) {}
    }
    return mockDataSource.fetchBookings(status: status);
  }

  @override
  Future<BookingModel> getBookingById(String id) async {
    if (preferRemote && remoteDataSource != null) {
      try {
        return await remoteDataSource!.fetchBookingById(id);
      } catch (_) {}
    }
    return mockDataSource.fetchBookingById(id);
  }

  @override
  Future<BookingModel> createBooking(BookingModel booking) async {
    if (preferRemote && remoteDataSource != null) {
      try {
        return await remoteDataSource!.createBooking(booking.toJson());
      } catch (_) {}
    }
    return mockDataSource.addBooking(booking);
  }

  @override
  Future<Map<String, dynamic>> calculatePrice(Map<String, dynamic> payload) async {
    if (preferRemote && remoteDataSource != null) {
      try {
        return await remoteDataSource!.calculateBookingPrice(payload);
      } catch (_) {}
    }
    return {};
  }

  @override
  Future<bool> cancelBooking(String id) async {
    if (preferRemote && remoteDataSource != null) {
      try {
        await remoteDataSource!.cancelBooking(id);
      } catch (_) {}
    }
    return mockDataSource.cancelBooking(id);
  }
}
