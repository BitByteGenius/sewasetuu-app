import 'package:get/get.dart';
import 'package:sewasetu/modules/bookings/models/booking_model.dart';
import 'package:sewasetu/shared/enums/booking_status.dart';

/// Controller managing reservations across Upcoming, Completed, and Cancelled tabs
class BookingsController extends GetxController {
  final RxInt selectedTab = 0.obs; // 0: Upcoming, 1: Completed, 2: Cancelled

  final RxList<BookingModel> allBookings = <BookingModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialBookings();
  }

  void _loadInitialBookings() {
    final now = DateTime.now();

    allBookings.assignAll([
      BookingModel(
        id: 'b-101',
        bookingCode: '#SS-72914',
        stayId: 'stay-1',
        stayTitle: 'The Grand Heritage Villa & Homestay',
        stayCity: 'Shillong, Meghalaya',
        stayAddress: 'Laitumkhrah, Upper Shillong',
        stayImageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=600&q=80',
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
        stayImageUrl: 'https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?auto=format&fit=crop&w=600&q=80',
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
        stayImageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=600&q=80',
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

  List<BookingModel> get upcomingBookings =>
      allBookings.where((b) => b.status == BookingStatus.confirmed || b.status == BookingStatus.ongoing).toList();

  List<BookingModel> get completedBookings =>
      allBookings.where((b) => b.status == BookingStatus.completed).toList();

  List<BookingModel> get cancelledBookings =>
      allBookings.where((b) => b.status == BookingStatus.cancelled).toList();

  void addBooking(BookingModel booking) {
    allBookings.insert(0, booking);
  }

  void switchTab(int index) {
    selectedTab.value = index;
  }
}

typedef BookingController = BookingsController;
