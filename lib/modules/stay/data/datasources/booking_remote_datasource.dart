import 'package:sewasetu/core/constants/api_constants.dart';
import 'package:sewasetu/core/network/api_client.dart';
import 'package:sewasetu/modules/stay/bookings/models/booking_model.dart';

/// Contract for Booking Remote API Data Source
abstract class IBookingRemoteDataSource {
  Future<List<BookingModel>> fetchBookings({String? status});
  Future<BookingModel> fetchBookingById(String id);
  Future<BookingModel> createBooking(Map<String, dynamic> bookingPayload);
  Future<Map<String, dynamic>> calculateBookingPrice(Map<String, dynamic> payload);
  Future<bool> cancelBooking(String id);
}

/// Dio implementation of IBookingRemoteDataSource
class BookingRemoteDataSourceImpl implements IBookingRemoteDataSource {
  final IApiClient apiClient;

  BookingRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<BookingModel>> fetchBookings({String? status}) async {
    final queryParams = status != null ? {'status': status} : null;
    final response = await apiClient.get(
      ApiConstants.bookings,
      queryParameters: queryParams,
    );

    final List dynamicList = (response.data is Map && response.data['data'] is List)
        ? response.data['data'] as List
        : (response.data is List ? response.data as List : []);

    return dynamicList
        .map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<BookingModel> fetchBookingById(String id) async {
    final path = ApiConstants.bookingDetailsPath(id);
    final response = await apiClient.get(path);

    final Map<String, dynamic> data = (response.data is Map && response.data['data'] is Map)
        ? response.data['data'] as Map<String, dynamic>
        : (response.data as Map<String, dynamic>);

    return BookingModel.fromJson(data);
  }

  @override
  Future<BookingModel> createBooking(Map<String, dynamic> bookingPayload) async {
    final response = await apiClient.post(
      ApiConstants.createBooking,
      data: bookingPayload,
    );

    final Map<String, dynamic> data = (response.data is Map && response.data['data'] is Map)
        ? response.data['data'] as Map<String, dynamic>
        : (response.data as Map<String, dynamic>);

    return BookingModel.fromJson(data);
  }

  @override
  Future<Map<String, dynamic>> calculateBookingPrice(Map<String, dynamic> payload) async {
    final response = await apiClient.post(
      ApiConstants.calculateBookingPrice,
      data: payload,
    );

    if (response.data is Map<String, dynamic>) {
      return response.data as Map<String, dynamic>;
    }
    return {};
  }

  @override
  Future<bool> cancelBooking(String id) async {
    final path = ApiConstants.cancelBookingPath(id);
    final response = await apiClient.post(path);
    return response.statusCode == 200 || response.statusCode == 204;
  }
}
