import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../shared/enums/view_state.dart';
import '../data/repositories/shop_repository.dart';
import '../data/repositories/shop_repository_impl.dart';
import '../models/product_model.dart';
import '../models/shop_category_model.dart';
import '../models/shop_state_model.dart';

/// Controller for full-text search across Products, States, Categories, and Tags
class ShopSearchController extends GetxController {
  final ShopRepository repository;

  ShopSearchController({ShopRepository? repository})
      : repository = repository ?? ShopRepositoryImpl();

  final TextEditingController textController = TextEditingController();
  final Rx<ViewState> state = ViewState.initial.obs;

  final RxList<ProductModel> searchResults = <ProductModel>[].obs;
  final RxList<ShopStateModel> matchingStates = <ShopStateModel>[].obs;
  final RxList<ShopCategoryModel> matchingCategories = <ShopCategoryModel>[].obs;

  final RxList<String> recentSearches = <String>[
    'Muga Silk',
    'Makhana',
    'Madhubani Painting',
    'Assam Orthodox Tea',
    'Blue Pottery',
    'Lakadong Turmeric',
    'Pashmina Shawl',
  ].obs;

  Timer? _debounceTimer;

  @override
  void onClose() {
    textController.dispose();
    _debounceTimer?.cancel();
    super.onClose();
  }

  void onQueryChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      performSearch(query);
    });
  }

  Future<void> performSearch(String query) async {
    final clean = query.trim();
    if (clean.isEmpty) {
      searchResults.clear();
      matchingStates.clear();
      matchingCategories.clear();
      state.value = ViewState.initial;
      return;
    }

    try {
      state.value = ViewState.loading;

      // 1. Search products
      final results = await repository.searchProducts(clean);
      searchResults.assignAll(results);

      // 2. Match states
      final allStates = await repository.getAllStates();
      matchingStates.assignAll(
        allStates.where((s) =>
            s.name.toLowerCase().contains(clean.toLowerCase()) ||
            s.culturalHighlights.any(
                (h) => h.toLowerCase().contains(clean.toLowerCase()))),
      );

      // 3. Match categories
      final allCats = await repository.getCategories();
      matchingCategories.assignAll(
        allCats.where(
          (c) => c.name.toLowerCase().contains(clean.toLowerCase()),
        ),
      );

      if (searchResults.isEmpty &&
          matchingStates.isEmpty &&
          matchingCategories.isEmpty) {
        state.value = ViewState.empty;
      } else {
        state.value = ViewState.loaded;
      }

      // Add to recent search
      if (!recentSearches.contains(clean)) {
        recentSearches.insert(0, clean);
        if (recentSearches.length > 8) {
          recentSearches.removeLast();
        }
      }
    } catch (_) {
      state.value = ViewState.error;
    }
  }

  void clearSearch() {
    textController.clear();
    searchResults.clear();
    matchingStates.clear();
    matchingCategories.clear();
    state.value = ViewState.initial;
  }

  void removeRecentSearch(String item) {
    recentSearches.remove(item);
  }
}
