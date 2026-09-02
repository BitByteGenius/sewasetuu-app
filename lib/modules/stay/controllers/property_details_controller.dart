import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/modules/stay/models/property_details_model.dart';
import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/modules/stay/models/review_model.dart';
import 'package:sewasetu/modules/stay/services/stay_service.dart';
import 'package:sewasetu/shared/enums/view_state.dart';

/// Controller for property details view and reservation triggers
class PropertyDetailsController extends GetxController {
  final StayService stayService = StayService();

  PropertyDetailsController({
    dynamic getStayDetailsUseCase,
    dynamic getStaysUseCase,
  });

  final Rx<ViewState> state = ViewState.initial.obs;
  final Rx<PropertyModel?> stay = Rx<PropertyModel?>(null);
  final RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  final RxList<PropertyModel> similarStays = <PropertyModel>[].obs;
  final RxBool isFavorite = false.obs;

  // Selected Room Option
  final RxString selectedRoomId = 'room-std'.obs;
  final RxList<RoomOptionItem> availableRooms = <RoomOptionItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    final stayId = Get.arguments as String? ?? 'stay-1';
    loadDetails(stayId);
  }

  Future<void> loadDetails(String stayId) async {
    try {
      state.value = ViewState.loading;
      final fetchedStay = await stayService.getStayById(stayId);
      final fetchedReviews = await stayService.getStayReviews(stayId);
      final allStays = await stayService.getStays();

      stay.value = fetchedStay;
      isFavorite.value = fetchedStay.isFavorite;
      reviews.assignAll(fetchedReviews);
      similarStays.assignAll(allStays.where((s) => s.id != stayId).take(4).toList());

      // Initialize room options tailored to this stay
      availableRooms.assignAll([
        RoomOptionItem(
          id: 'room-std',
          title: 'Standard Cozy Room',
          bedType: '1 Queen Bed',
          maxGuests: '2 Guests',
          pricePerNight: fetchedStay.pricePerNight,
          highlights: const ['Attached Washroom', 'High-Speed Wi-Fi', 'Daily Cleaning'],
        ),
        RoomOptionItem(
          id: 'room-dlx',
          title: 'Deluxe Balcony Suite',
          bedType: '1 King Bed + Mountain View',
          maxGuests: '3 Guests',
          pricePerNight: fetchedStay.pricePerNight * 1.35,
          highlights: const ['Private Balcony', 'Smart TV', 'Complimentary Breakfast', 'Geyser'],
        ),
        RoomOptionItem(
          id: 'room-exec',
          title: 'Executive Studio Penthouse',
          bedType: '2 King Beds + Living Lounge',
          maxGuests: '4 Guests',
          pricePerNight: fetchedStay.pricePerNight * 1.8,
          highlights: const ['Kitchenette', 'Panoramic Pine View', 'Bathtub', 'Dedicated Host'],
        ),
      ]);

      state.value = ViewState.loaded;
    } catch (_) {
      state.value = ViewState.error;
    }
  }

  void toggleFavorite() {
    if (stay.value != null) {
      isFavorite.value = !isFavorite.value;
      stay.value = stay.value!.copyWith(isFavorite: isFavorite.value);
    }
  }

  void selectRoom(RoomOptionItem room) {
    selectedRoomId.value = room.id;
  }

  void openGallery(int initialIndex) {
    if (stay.value != null) {
      Get.toNamed(
        AppRoutes.fullScreenGallery,
        arguments: {
          'images': stay.value!.images,
          'initialIndex': initialIndex,
        },
      );
    }
  }

  /// Launch the multi-step booking checkout flow
  void initiateBooking() {
    if (stay.value == null) return;
    final selectedRoom = availableRooms.firstWhere(
      (r) => r.id == selectedRoomId.value,
      orElse: () => availableRooms.first,
    );

    Get.toNamed(
      AppRoutes.bookingCheckout,
      arguments: {
        'stay': stay.value!,
        'room': selectedRoom,
      },
    );
  }
}
