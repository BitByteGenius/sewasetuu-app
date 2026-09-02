import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/property_details/domain/usecases/get_stay_details_usecase.dart';
import 'package:sewasetu/modules/stay/property/domain/entities/stay_entity.dart';
import 'package:sewasetu/modules/stay/review/domain/entities/review_entity.dart';
import 'package:sewasetu/shared/enums/view_state.dart';

/// Controller for property details view and reservation triggers.
class PropertyDetailsController extends GetxController {
  final GetStayDetailsUseCase getStayDetailsUseCase;

  PropertyDetailsController({required this.getStayDetailsUseCase});

  final Rx<ViewState> state = ViewState.initial.obs;
  final Rx<StayEntity?> stay = Rx<StayEntity?>(null);
  final RxList<StayReviewEntity> reviews = <StayReviewEntity>[].obs;
  final RxBool isFavorite = false.obs;
  final RxBool isBooking = false.obs;

  @override
  void onInit() {
    super.onInit();
    final stayId = Get.arguments as String? ?? 'stay-1';
    loadDetails(stayId);
  }

  Future<void> loadDetails(String stayId) async {
    try {
      state.value = ViewState.loading;
      final fetchedStay = await getStayDetailsUseCase.getDetails(stayId);
      final fetchedReviews = await getStayDetailsUseCase.getReviews(stayId);
      stay.value = fetchedStay;
      isFavorite.value = fetchedStay.isFavorite;
      reviews.assignAll(fetchedReviews);
      state.value = ViewState.loaded;
    } catch (e) {
      state.value = ViewState.error;
    }
  }

  void toggleFavorite() {
    if (stay.value != null) {
      isFavorite.value = !isFavorite.value;
      stay.value = stay.value!.copyWith(isFavorite: isFavorite.value);
    }
  }

  Future<void> initiateBooking() async {
    isBooking.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    isBooking.value = false;
    Get.snackbar(
      'Reservation Initiated',
      'Proceeding to booking confirmation for ${stay.value?.title ?? 'Stay'}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
