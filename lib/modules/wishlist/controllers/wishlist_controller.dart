import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/modules/stay/services/stay_service.dart';
import 'package:sewasetu/shared/enums/view_state.dart';

class WishlistController extends GetxController {
  final StayService stayService;

  WishlistController({StayService? stayService, dynamic getStaysUseCase})
      : stayService = stayService ?? StayService();

  final Rx<ViewState> state = ViewState.loading.obs;
  final RxList<PropertyModel> savedStays = <PropertyModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadWishlist();
  }

  Future<void> loadWishlist() async {
    try {
      state.value = ViewState.loading;
      final stays = await stayService.getStays();
      savedStays.assignAll(stays.take(3).toList());
      state.value = ViewState.loaded;
    } catch (_) {
      state.value = ViewState.error;
    }
  }

  void removeFavorite(String id) {
    savedStays.removeWhere((s) => s.id == id);
  }
}
