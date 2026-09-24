import 'package:get/get.dart';
import 'package:sewasetu/core/network/api_client.dart';
import 'package:sewasetu/modules/stay/bookings/controllers/bookings_controller.dart';
import 'package:sewasetu/modules/stay/data/datasources/booking_mock_datasource.dart';
import 'package:sewasetu/modules/stay/data/datasources/booking_remote_datasource.dart';
import 'package:sewasetu/modules/stay/data/repositories/booking_repository_impl.dart';
import 'package:sewasetu/modules/stay/domain/repositories/booking_repository.dart';

/// Bindings for Bookings Module
class BookingsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<IBookingMockDataSource>()) {
      Get.lazyPut<IBookingMockDataSource>(() => BookingMockDataSourceImpl(), fenix: true);
    }
    if (Get.isRegistered<IApiClient>() && !Get.isRegistered<IBookingRemoteDataSource>()) {
      Get.lazyPut<IBookingRemoteDataSource>(
        () => BookingRemoteDataSourceImpl(Get.find<IApiClient>()),
        fenix: true,
      );
    }
    if (!Get.isRegistered<IBookingRepository>()) {
      Get.lazyPut<IBookingRepository>(
        () => BookingRepositoryImpl(
          remoteDataSource: Get.isRegistered<IBookingRemoteDataSource>()
              ? Get.find<IBookingRemoteDataSource>()
              : null,
          mockDataSource: Get.find<IBookingMockDataSource>(),
        ),
        fenix: true,
      );
    }
    Get.lazyPut<BookingsController>(
      () => BookingsController(bookingRepository: Get.find<IBookingRepository>()),
      fenix: true,
    );
  }
}

typedef BookingBinding = BookingsBinding;
