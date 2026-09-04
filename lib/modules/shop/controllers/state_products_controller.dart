import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../shared/enums/view_state.dart';
import '../data/repositories/shop_repository.dart';
import '../data/repositories/shop_repository_impl.dart';
import '../models/product_model.dart';
import '../models/shop_category_model.dart';
import '../models/shop_state_model.dart';

/// Controller for displaying, sorting and filtering products of a specific state
class StateProductsController extends GetxController {
  final ShopRepository repository;
  final ShopStateModel stateModel;

  StateProductsController({
    required this.stateModel,
    ShopRepository? repository,
  }) : repository = repository ?? ShopRepositoryImpl();

  final Rx<ViewState> state = ViewState.initial.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxList<ShopCategoryModel> categories = <ShopCategoryModel>[].obs;

  // Filters
  final RxString selectedCategoryId = 'all'.obs;
  final RxString currentSort = 'popular'.obs;
  final Rx<RangeValues> priceRange = const RangeValues(100, 30000).obs;
  final RxDouble minRating = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategoriesAndProducts();
  }

  Future<void> loadCategoriesAndProducts() async {
    try {
      state.value = ViewState.loading;
      final cats = await repository.getCategories();
      categories.assignAll(cats);

      await fetchProducts();
    } catch (_) {
      state.value = ViewState.error;
    }
  }

  Future<void> fetchProducts() async {
    try {
      state.value = ViewState.loading;
      final result = await repository.getProductsByState(
        stateModel.id,
        categoryId: selectedCategoryId.value,
        sortBy: currentSort.value,
        priceRange: priceRange.value,
        minRating: minRating.value,
      );

      products.assignAll(result);
      if (products.isEmpty) {
        state.value = ViewState.empty;
      } else {
        state.value = ViewState.loaded;
      }
    } catch (_) {
      state.value = ViewState.error;
    }
  }

  void selectCategory(String categoryId) {
    if (selectedCategoryId.value == categoryId) {
      selectedCategoryId.value = 'all';
    } else {
      selectedCategoryId.value = categoryId;
    }
    fetchProducts();
  }

  void applySort(String sortOption) {
    currentSort.value = sortOption;
    fetchProducts();
  }

  void applyFilters({
    RangeValues? newPriceRange,
    double? newMinRating,
  }) {
    if (newPriceRange != null) priceRange.value = newPriceRange;
    if (newMinRating != null) minRating.value = newMinRating;
    fetchProducts();
  }

  void resetFilters() {
    selectedCategoryId.value = 'all';
    currentSort.value = 'popular';
    priceRange.value = const RangeValues(100, 30000);
    minRating.value = 0.0;
    fetchProducts();
  }
}
