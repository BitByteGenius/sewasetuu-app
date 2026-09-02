import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/property/domain/entities/stay_entity.dart';
import 'package:sewasetu/modules/stay/property/domain/usecases/get_stays_usecase.dart';
import 'package:sewasetu/shared/enums/view_state.dart';

class WishlistController extends GetxController {
  final GetStaysUseCase getStaysUseCase;

  WishlistController({required this.getStaysUseCase});

  final Rx<ViewState> state = ViewState.loading.obs;
  final RxList<StayEntity> savedStays = <StayEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadWishlist();
  }

  Future<void> loadWishlist() async {
    try {
      state.value = ViewState.loading;
      final stays = await getStaysUseCase();
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
