import 'package:get/get.dart';
import '../controllers/bookings_controller.dart';

/// Bindings for Bookings Module
class BookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingsController>(() => BookingsController(), fenix: true);
  }
}

typedef BookingBinding = BookingsBinding;
