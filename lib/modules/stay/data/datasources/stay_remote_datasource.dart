import 'package:sewasetu/core/constants/api_constants.dart';
import 'package:sewasetu/core/network/api_client.dart';
import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/modules/stay/models/review_model.dart';
import 'package:sewasetu/modules/stay/models/stay_filter_criteria.dart';

/// Abstract contract for Stay Remote API Data Source
abstract class IStayRemoteDataSource {
  Future<List<PropertyModel>> fetchStays({
    StayFilterCriteria? filter,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  });
  Future<PropertyModel> fetchStayById(String id);
  Future<List<PropertyModel>> fetchFeaturedStays();
  Future<List<PropertyModel>> fetchNearbyStays({required String city});
  Future<List<ReviewModel>> fetchStayReviews(String stayId);
  Future<bool> toggleFavorite(String stayId, bool isFavorite);
  Future<List<PropertyModel>> fetchSavedStays();
}

/// Dio implementation of IStayRemoteDataSource consuming ApiConstants
class StayRemoteDataSourceImpl implements IStayRemoteDataSource {
  final IApiClient apiClient;

  StayRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<PropertyModel>> fetchStays({
    StayFilterCriteria? filter,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  }) async {
    final Map<String, dynamic> queryParams = {
      'page': page,
      'limit': limit,
    };

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      queryParams['q'] = searchQuery.trim();
    }

    if (filter != null) {
      if (filter.stayType != null) {
        queryParams['stay_type'] = filter.stayType!.name;
      }
      if (filter.minPrice != null) {
        queryParams['min_price'] = filter.minPrice;
      }
      if (filter.maxPrice != null) {
        queryParams['max_price'] = filter.maxPrice;
      }
      if (filter.minRating != null) {
        queryParams['min_rating'] = filter.minRating;
      }
      if (filter.city != null && filter.city!.isNotEmpty) {
        queryParams['city'] = filter.city;
      }
      if (filter.verifiedOnly == true) {
        queryParams['verified_only'] = true;
      }
      if (filter.amenities.isNotEmpty) {
        queryParams['amenities'] = filter.amenities.join(',');
      }
    }

    final response = await apiClient.get(
      ApiConstants.stays,
      queryParameters: queryParams,
    );

    final List dynamicList = (response.data is Map && response.data['data'] is List)
        ? response.data['data'] as List
        : (response.data is List ? response.data as List : []);

    return dynamicList
        .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PropertyModel> fetchStayById(String id) async {
    final path = ApiConstants.stayDetailsPath(id);
    final response = await apiClient.get(path);

    final Map<String, dynamic> data = (response.data is Map && response.data['data'] is Map)
        ? response.data['data'] as Map<String, dynamic>
        : (response.data as Map<String, dynamic>);

    return PropertyModel.fromJson(data);
  }

  @override
  Future<List<PropertyModel>> fetchFeaturedStays() async {
    final response = await apiClient.get(ApiConstants.featuredStays);

    final List dynamicList = (response.data is Map && response.data['data'] is List)
        ? response.data['data'] as List
        : (response.data is List ? response.data as List : []);

    return dynamicList
        .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<PropertyModel>> fetchNearbyStays({required String city}) async {
    final response = await apiClient.get(
      ApiConstants.nearbyStays,
      queryParameters: {'city': city},
    );

    final List dynamicList = (response.data is Map && response.data['data'] is List)
        ? response.data['data'] as List
        : (response.data is List ? response.data as List : []);

    return dynamicList
        .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ReviewModel>> fetchStayReviews(String stayId) async {
    final path = ApiConstants.stayReviewsPath(stayId);
    final response = await apiClient.get(path);

    final List dynamicList = (response.data is Map && response.data['data'] is List)
        ? response.data['data'] as List
        : (response.data is List ? response.data as List : []);

    return dynamicList
        .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<bool> toggleFavorite(String stayId, bool isFavorite) async {
    final response = await apiClient.post(
      ApiConstants.toggleWishlist,
      data: {
        'stay_id': stayId,
        'is_favorite': isFavorite,
      },
    );

    if (response.data is Map && response.data['is_favorite'] is bool) {
      return response.data['is_favorite'] as bool;
    }
    return isFavorite;
  }

  @override
  Future<List<PropertyModel>> fetchSavedStays() async {
    final response = await apiClient.get(ApiConstants.wishlist);

    final List dynamicList = (response.data is Map && response.data['data'] is List)
        ? response.data['data'] as List
        : (response.data is List ? response.data as List : []);

    return dynamicList
        .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
