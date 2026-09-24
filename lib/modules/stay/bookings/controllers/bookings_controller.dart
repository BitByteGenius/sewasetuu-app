import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/bookings/models/booking_model.dart';
import 'package:sewasetu/modules/stay/data/repositories/booking_repository_impl.dart';
import 'package:sewasetu/modules/stay/domain/repositories/booking_repository.dart';
import 'package:sewasetu/shared/enums/booking_status.dart';

/// Controller managing reservations across Upcoming, Completed, and Cancelled tabs
class BookingsController extends GetxController {
  final IBookingRepository _bookingRepository;

  BookingsController({IBookingRepository? bookingRepository})
      : _bookingRepository = bookingRepository ??
            (Get.isRegistered<IBookingRepository>()
                ? Get.find<IBookingRepository>()
                : BookingRepositoryImpl());

  final RxInt selectedTab = 0.obs; // 0: Upcoming, 1: Completed, 2: Cancelled

  final RxList<BookingModel> allBookings = <BookingModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadBookings();
  }

  Future<void> loadBookings() async {
    try {
      isLoading.value = true;
      final result = await _bookingRepository.getBookings();
      allBookings.assignAll(result);
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  List<BookingModel> get upcomingBookings =>
      allBookings.where((b) => b.status == BookingStatus.confirmed || b.status == BookingStatus.ongoing).toList();

  List<BookingModel> get completedBookings =>
      allBookings.where((b) => b.status == BookingStatus.completed).toList();

  List<BookingModel> get cancelledBookings =>
      allBookings.where((b) => b.status == BookingStatus.cancelled).toList();

  Future<void> addBooking(BookingModel booking) async {
    final created = await _bookingRepository.createBooking(booking);
    allBookings.insert(0, created);
  }

  Future<void> cancelBooking(String bookingId) async {
    final success = await _bookingRepository.cancelBooking(bookingId);
    if (success) {
      final index = allBookings.indexWhere((b) => b.id == bookingId);
      if (index != -1) {
        allBookings[index] = allBookings[index].copyWith(status: BookingStatus.cancelled);
      }
    }
  }

  void switchTab(int index) {
    selectedTab.value = index;
  }
}

typedef BookingController = BookingsController;
