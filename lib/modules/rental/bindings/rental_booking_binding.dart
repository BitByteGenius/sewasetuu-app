import 'package:get/get.dart';
import '../controllers/rental_booking_controller.dart';
import '../data/repositories/rental_repository.dart';
import '../data/repositories/rental_repository_impl.dart';

/// Dependency injection binding for the Rental Booking and Checkout flow.
class RentalBookingBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<RentalRepository>()) {
      Get.lazyPut<RentalRepository>(() => RentalRepositoryImpl());
    }

    Get.lazyPut<RentalBookingController>(
      () => RentalBookingController(repository: Get.find<RentalRepository>()),
    );
  }
}
