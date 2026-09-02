import 'package:sewasetu/modules/stay/property/domain/entities/stay_entity.dart';
import 'package:sewasetu/modules/stay/filter/domain/entities/stay_filter_criteria.dart';
import 'package:sewasetu/modules/stay/review/domain/entities/review_entity.dart';

/// Contract definition for Stay data operations (Pure Domain Layer)
abstract class IStayRepository {
  Future<List<StayEntity>> getStays({
    StayFilterCriteria? filter,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  });

  Future<List<StayEntity>> getFeaturedStays();

  Future<List<StayEntity>> getNearbyStays({required String city});

  Future<StayEntity> getStayById(String id);

  Future<List<StayReviewEntity>> getStayReviews(String stayId);

  Future<bool> toggleFavorite(String stayId, bool isFavorite);
}
