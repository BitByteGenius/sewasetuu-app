import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/property/domain/entities/stay_entity.dart';
import 'package:sewasetu/modules/stay/property/domain/usecases/get_stays_usecase.dart';
import 'package:sewasetu/modules/stay/filter/domain/entities/stay_filter_criteria.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';
import 'package:sewasetu/shared/enums/view_state.dart';

/// Controller managing the stay listing feed, category tabs, and filters.
class StayListController extends GetxController {
  final GetStaysUseCase getStaysUseCase;

  StayListController({required this.getStaysUseCase});

  final Rx<ViewState> state = ViewState.initial.obs;
  final RxList<StayEntity> stays = <StayEntity>[].obs;
  final Rx<StayType?> selectedCategory = Rx<StayType?>(null);
  final Rx<StayFilterCriteria> currentFilter = const StayFilterCriteria().obs;
  final RxBool isGridView = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is StayType) {
      selectedCategory.value = Get.arguments as StayType;
      currentFilter.value = currentFilter.value.copyWith(stayType: selectedCategory.value);
    }
    loadStays();
  }

  Future<void> loadStays() async {
    try {
      state.value = ViewState.loading;
      final result = await getStaysUseCase(
        filter: currentFilter.value,
      );
      stays.assignAll(result);
      if (stays.isEmpty) {
        state.value = ViewState.empty;
      } else {
        state.value = ViewState.loaded;
      }
    } catch (e) {
      state.value = ViewState.error;
    }
  }

  void onCategorySelected(StayType? type) {
    selectedCategory.value = type;
    currentFilter.value = currentFilter.value.copyWith(stayType: type);
    loadStays();
  }

  void applyFilter(StayFilterCriteria criteria) {
    currentFilter.value = criteria;
    selectedCategory.value = criteria.stayType;
    loadStays();
  }

  void toggleFavorite(String stayId, bool currentFavorite) async {
    final index = stays.indexWhere((s) => s.id == stayId);
    if (index != -1) {
      final updated = stays[index].copyWith(isFavorite: !currentFavorite);
      stays[index] = updated;
      await getStaysUseCase.toggleFavorite(stayId, currentFavorite);
    }
  }

  void toggleViewLayout() {
    isGridView.value = !isGridView.value;
  }
}
