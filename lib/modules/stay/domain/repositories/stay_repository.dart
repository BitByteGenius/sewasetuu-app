import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/modules/stay/models/review_model.dart';
import 'package:sewasetu/modules/stay/models/stay_filter_criteria.dart';

/// Clean domain repository contract for Stay & Accommodation data operations
abstract class IStayRepository {
  /// Fetches stays matching criteria or search query with pagination
  Future<List<PropertyModel>> getStays({
    StayFilterCriteria? filter,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  });

  /// Fetches featured stays for home/hero feed
  Future<List<PropertyModel>> getFeaturedStays();

  /// Fetches nearby stays for a specified city or location
  Future<List<PropertyModel>> getNearbyStays({required String city});

  /// Fetches saved / wishlist properties
  Future<List<PropertyModel>> getSavedStays();

  /// Fetches single property by ID
  Future<PropertyModel> getStayById(String id);

  /// Fetches reviews for a property
  Future<List<ReviewModel>> getStayReviews(String stayId);

  /// Toggles favorite/wishlist status of a stay property
  Future<bool> toggleFavorite(String stayId, bool isFavorite);
}
