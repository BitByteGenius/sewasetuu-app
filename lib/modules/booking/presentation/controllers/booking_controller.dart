import 'package:get/get.dart';
import '../../../../shared/enums/booking_status.dart';
import '../../../../shared/enums/view_state.dart';

class BookingItem {
  final String id;
  final String title;
  final String stayType;
  final String imageUrl;
  final String dates;
  final double totalAmount;
  final BookingStatus status;

  const BookingItem({
    required this.id,
    required this.title,
    required this.stayType,
    required this.imageUrl,
    required this.dates,
    required this.totalAmount,
    required this.status,
  });
}

class BookingController extends GetxController {
  final Rx<ViewState> state = ViewState.loaded.obs;
  final RxList<BookingItem> bookings = <BookingItem>[
    const BookingItem(
      id: 'BKG-901',
      title: 'The Grand Heritage Villa & Homestay',
      stayType: 'Homestay',
      imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=600&q=80',
      dates: '12 Sep - 15 Sep, 2026',
      totalAmount: 9600,
      status: BookingStatus.confirmed,
    ),
    const BookingItem(
      id: 'BKG-840',
      title: 'Green Nest Luxury PG',
      stayType: 'PG',
      imageUrl: 'https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?auto=format&fit=crop&w=600&q=80',
      dates: '01 Aug - 31 Aug, 2026',
      totalAmount: 8500,
      status: BookingStatus.completed,
    ),
  ].obs;
}
