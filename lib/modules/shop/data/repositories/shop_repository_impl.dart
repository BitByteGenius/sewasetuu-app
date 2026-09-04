import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../models/product_review_model.dart';
import '../../models/shop_category_model.dart';
import '../../models/shop_state_model.dart';
import '../datasources/shop_mock_datasource.dart';
import 'shop_repository.dart';

/// Implementation of ShopRepository backed by ShopMockDatasource
/// Easily swappable with an ApiClient implementation later
class ShopRepositoryImpl implements ShopRepository {
  final ShopMockDatasource datasource;

  ShopRepositoryImpl({ShopMockDatasource? datasource})
      : datasource = datasource ?? ShopMockDatasource();

  @override
  Future<List<ShopStateModel>> getFeaturedStates() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return ShopMockDatasource.states.where((s) => s.isFeatured).toList();
  }

  @override
  Future<List<ShopStateModel>> getAllStates() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(ShopMockDatasource.states);
  }

  @override
  Future<ShopStateModel?> getStateById(String stateId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return ShopMockDatasource.states.firstWhere(
        (s) => s.id == stateId || s.slug == stateId,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<ShopCategoryModel>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 120));
    return List.from(ShopMockDatasource.categories);
  }

  @override
  Future<List<ProductModel>> getFeaturedProducts() async {
    await Future.delayed(const Duration(milliseconds: 180));
    return ShopMockDatasource.products.where((p) => p.isFeatured).toList();
  }

  @override
  Future<List<ProductModel>> getPopularProducts() async {
    await Future.delayed(const Duration(milliseconds: 180));
    return ShopMockDatasource.products.where((p) => p.isPopular).toList();
  }

  @override
  Future<List<ProductModel>> getProductsByState(
    String stateId, {
    String? categoryId,
    String? sortBy,
    RangeValues? priceRange,
    double? minRating,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    var list = ShopMockDatasource.products.where((p) {
      if (p.stateId != stateId) return false;
      if (categoryId != null && categoryId.isNotEmpty && categoryId != 'all') {
        if (p.categoryId != categoryId) return false;
      }
      if (priceRange != null) {
        if (p.price < priceRange.start || p.price > priceRange.end) return false;
      }
      if (minRating != null && minRating > 0) {
        if (p.rating < minRating) return false;
      }
      return true;
    }).toList();

    _applySort(list, sortBy);
    return list;
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 180));
    return ShopMockDatasource.products
        .where((p) => p.categoryId == categoryId)
        .toList();
  }

  @override
  Future<List<ProductModel>> searchProducts(
    String query, {
    String? stateId,
    String? categoryId,
    String? sortBy,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final q = query.toLowerCase().trim();

    var list = ShopMockDatasource.products.where((p) {
      if (stateId != null && stateId.isNotEmpty && p.stateId != stateId) {
        return false;
      }
      if (categoryId != null && categoryId.isNotEmpty && categoryId != 'all') {
        if (p.categoryId != categoryId) return false;
      }

      if (q.isEmpty) return true;

      final matchName = p.name.toLowerCase().contains(q);
      final matchState = p.stateName.toLowerCase().contains(q);
      final matchCat = p.categoryName.toLowerCase().contains(q);
      final matchDesc = p.shortDescription.toLowerCase().contains(q);
      final matchTags = p.tags.any((t) => t.toLowerCase().contains(q));

      return matchName || matchState || matchCat || matchDesc || matchTags;
    }).toList();

    _applySort(list, sortBy);
    return list;
  }

  @override
  Future<ProductModel?> getProductDetails(String productId) async {
    await Future.delayed(const Duration(milliseconds: 120));
    try {
      return ShopMockDatasource.products.firstWhere((p) => p.id == productId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<ProductReviewModel>> getProductReviews(String productId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return ShopMockDatasource.getReviewsForProduct(productId);
  }

  void _applySort(List<ProductModel> list, String? sortBy) {
    if (sortBy == null) return;
    switch (sortBy) {
      case 'price_low_high':
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high_low':
        list.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'rating_high':
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'newest':
        // Keep order or sort by ID
        break;
      case 'popular':
      default:
        list.sort((a, b) => (b.isPopular ? 1 : 0).compareTo(a.isPopular ? 1 : 0));
        break;
    }
  }
}
