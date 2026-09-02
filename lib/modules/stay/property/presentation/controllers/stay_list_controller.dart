import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/filter/domain/entities/stay_filter_criteria.dart';
import 'package:sewasetu/modules/stay/property/domain/entities/stay_entity.dart';
import 'package:sewasetu/modules/stay/property/domain/usecases/get_stays_usecase.dart';
import 'package:sewasetu/modules/stay/property/presentation/widgets/stay_sorting_sheet.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';
import 'package:sewasetu/shared/enums/view_state.dart';

enum StayViewMode { list, grid, map }

/// Controller managing the stay listing feed, category tabs, sorting, and map view
class StayListController extends GetxController {
  final GetStaysUseCase getStaysUseCase;

  StayListController({required this.getStaysUseCase});

  final Rx<ViewState> state = ViewState.initial.obs;
  final RxList<StayEntity> stays = <StayEntity>[].obs;
  final Rx<StayType?> selectedCategory = Rx<StayType?>(null);
  final Rx<StayFilterCriteria> currentFilter = const StayFilterCriteria().obs;
  final Rx<StayViewMode> viewMode = StayViewMode.list.obs;
  final Rx<StaySortOption> currentSort = StaySortOption.recommended.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is StayType) {
      selectedCategory.value = Get.arguments as StayType;
      currentFilter.value = currentFilter.value.copyWith(stayType: selectedCategory.value);
    } else if (Get.arguments is StayFilterCriteria) {
      currentFilter.value = Get.arguments as StayFilterCriteria;
      selectedCategory.value = currentFilter.value.stayType;
    }
    loadStays();
  }

  Future<void> loadStays() async {
    try {
      state.value = ViewState.loading;
      final result = await getStaysUseCase(
        filter: currentFilter.value,
      );

      // Apply in-memory sort
      _applySorting(result);

      if (stays.isEmpty) {
        state.value = ViewState.empty;
      } else {
        state.value = ViewState.loaded;
      }
    } catch (_) {
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

  void applySort(StaySortOption option) {
    currentSort.value = option;
    final currentList = List<StayEntity>.from(stays);
    _applySorting(currentList);
  }

  void _applySorting(List<StayEntity> list) {
    switch (currentSort.value) {
      case StaySortOption.priceLowToHigh:
        list.sort((a, b) => a.pricePerNight.compareTo(b.pricePerNight));
        break;
      case StaySortOption.priceHighToLow:
        list.sort((a, b) => b.pricePerNight.compareTo(a.pricePerNight));
        break;
      case StaySortOption.ratingHighToLow:
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case StaySortOption.recommended:
        list.sort((a, b) => (b.isFeatured ? 1 : 0).compareTo(a.isFeatured ? 1 : 0));
        break;
    }
    stays.assignAll(list);
  }

  void toggleFavorite(String stayId, bool currentFavorite) async {
    final index = stays.indexWhere((s) => s.id == stayId);
    if (index != -1) {
      final updated = stays[index].copyWith(isFavorite: !currentFavorite);
      stays[index] = updated;
      await getStaysUseCase.toggleFavorite(stayId, currentFavorite);
    }
  }

  void setViewMode(StayViewMode mode) {
    viewMode.value = mode;
  }
}
