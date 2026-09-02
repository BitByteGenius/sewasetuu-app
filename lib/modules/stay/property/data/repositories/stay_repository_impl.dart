import 'package:sewasetu/modules/stay/property/data/datasources/stay_mock_datasource.dart';
import 'package:sewasetu/modules/stay/property/domain/entities/stay_entity.dart';
import 'package:sewasetu/modules/stay/property/domain/repositories/stay_repository.dart';
import 'package:sewasetu/modules/stay/filter/domain/entities/stay_filter_criteria.dart';
import 'package:sewasetu/modules/stay/review/domain/entities/review_entity.dart';

/// Concrete repository implementation for Stay module
class StayRepositoryImpl implements IStayRepository {
  final IStayDataSource _dataSource;

  StayRepositoryImpl(this._dataSource);

  @override
  Future<List<StayEntity>> getStays({
    StayFilterCriteria? filter,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  }) async {
    final allStays = await _dataSource.fetchStays();

    return allStays.where((stay) {
      // Search query filtering
      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        final query = searchQuery.toLowerCase().trim();
        final matchesTitle = stay.title.toLowerCase().contains(query);
        final matchesCity = stay.city.toLowerCase().contains(query);
        final matchesAddress = stay.address.toLowerCase().contains(query);
        final matchesType = stay.stayType.label.toLowerCase().contains(query);
        if (!matchesTitle && !matchesCity && !matchesAddress && !matchesType) {
          return false;
        }
      }

      // Filter criteria
      if (filter != null) {
        if (filter.stayType != null && stay.stayType != filter.stayType) {
          return false;
        }
        if (filter.minPrice != null && stay.pricePerNight < filter.minPrice!) {
          return false;
        }
        if (filter.maxPrice != null && stay.pricePerNight > filter.maxPrice!) {
          return false;
        }
        if (filter.minRating != null && stay.rating < filter.minRating!) {
          return false;
        }
        if (filter.verifiedOnly == true && !stay.isVerified) {
          return false;
        }
        if (filter.city != null && filter.city!.isNotEmpty) {
          if (!stay.city.toLowerCase().contains(filter.city!.toLowerCase())) {
            return false;
          }
        }
        if (filter.amenities.isNotEmpty) {
          final hasAllAmenities = filter.amenities.every(
            (reqAmenity) => stay.amenities.any(
              (a) => a.toLowerCase().contains(reqAmenity.toLowerCase()),
            ),
          );
          if (!hasAllAmenities) return false;
        }
      }

      return true;
    }).toList();
  }

  @override
  Future<List<StayEntity>> getFeaturedStays() async {
    final allStays = await _dataSource.fetchStays();
    return allStays.where((s) => s.isFeatured).toList();
  }

  @override
  Future<List<StayEntity>> getNearbyStays({required String city}) async {
    final allStays = await _dataSource.fetchStays();
    final inCity = allStays.where((s) => s.city.toLowerCase().contains(city.toLowerCase().split(',').first)).toList();
    if (inCity.isNotEmpty) return inCity;
    return allStays;
  }

  @override
  Future<StayEntity> getStayById(String id) async {
    return await _dataSource.fetchStayById(id);
  }

  @override
  Future<List<StayReviewEntity>> getStayReviews(String stayId) async {
    return await _dataSource.fetchStayReviews(stayId);
  }

  @override
  Future<bool> toggleFavorite(String stayId, bool isFavorite) async {
    return !isFavorite;
  }
}
