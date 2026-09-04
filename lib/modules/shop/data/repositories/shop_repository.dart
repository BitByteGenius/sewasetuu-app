import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../models/product_review_model.dart';
import '../../models/shop_category_model.dart';
import '../../models/shop_state_model.dart';

/// Contract interface for Shop e-commerce repository
abstract class ShopRepository {
  Future<List<ShopStateModel>> getFeaturedStates();
  Future<List<ShopStateModel>> getAllStates();
  Future<ShopStateModel?> getStateById(String stateId);
  Future<List<ShopCategoryModel>> getCategories();
  Future<List<ProductModel>> getFeaturedProducts();
  Future<List<ProductModel>> getPopularProducts();
  Future<List<ProductModel>> getProductsByState(
    String stateId, {
    String? categoryId,
    String? sortBy,
    RangeValues? priceRange,
    double? minRating,
  });
  Future<List<ProductModel>> getProductsByCategory(String categoryId);
  Future<List<ProductModel>> searchProducts(
    String query, {
    String? stateId,
    String? categoryId,
    String? sortBy,
  });
  Future<ProductModel?> getProductDetails(String productId);
  Future<List<ProductReviewModel>> getProductReviews(String productId);
}
