import 'package:sewasetu/modules/stay/data/datasources/stay_mock_datasource.dart';
import 'package:sewasetu/modules/stay/data/datasources/stay_remote_datasource.dart';
import 'package:sewasetu/modules/stay/domain/repositories/stay_repository.dart';
import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/modules/stay/models/review_model.dart';
import 'package:sewasetu/modules/stay/models/stay_filter_criteria.dart';

/// Implementation of IStayRepository managing Remote API calls with safe Mock Data fallback
class StayRepositoryImpl implements IStayRepository {
  final IStayRemoteDataSource? remoteDataSource;
  final IStayMockDataSource mockDataSource;
  final bool preferRemote;

  StayRepositoryImpl({
    this.remoteDataSource,
    IStayMockDataSource? mockDataSource,
    this.preferRemote = false,
  }) : mockDataSource = mockDataSource ?? StayMockDataSourceImpl();

  @override
  Future<List<PropertyModel>> getStays({
    StayFilterCriteria? filter,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  }) async {
    if (preferRemote && remoteDataSource != null) {
      try {
        return await remoteDataSource!.fetchStays(
          filter: filter,
          searchQuery: searchQuery,
          page: page,
          limit: limit,
        );
      } catch (_) {
        // Fallback to local mock data source on remote API failure or unconfigured endpoint
      }
    }
    return mockDataSource.getStays(filter: filter, searchQuery: searchQuery);
  }

  @override
  Future<List<PropertyModel>> getFeaturedStays() async {
    if (preferRemote && remoteDataSource != null) {
      try {
        return await remoteDataSource!.fetchFeaturedStays();
      } catch (_) {}
    }
    return mockDataSource.getFeaturedStays();
  }

  @override
  Future<List<PropertyModel>> getNearbyStays({required String city}) async {
    if (preferRemote && remoteDataSource != null) {
      try {
        return await remoteDataSource!.fetchNearbyStays(city: city);
      } catch (_) {}
    }
    return mockDataSource.getNearbyStays(city: city);
  }

  @override
  Future<List<PropertyModel>> getSavedStays() async {
    if (preferRemote && remoteDataSource != null) {
      try {
        return await remoteDataSource!.fetchSavedStays();
      } catch (_) {}
    }
    return mockDataSource.getSavedStays();
  }

  @override
  Future<PropertyModel> getStayById(String id) async {
    if (preferRemote && remoteDataSource != null) {
      try {
        return await remoteDataSource!.fetchStayById(id);
      } catch (_) {}
    }
    return mockDataSource.getStayById(id);
  }

  @override
  Future<List<ReviewModel>> getStayReviews(String stayId) async {
    if (preferRemote && remoteDataSource != null) {
      try {
        return await remoteDataSource!.fetchStayReviews(stayId);
      } catch (_) {}
    }
    return mockDataSource.getStayReviews(stayId);
  }

  @override
  Future<bool> toggleFavorite(String stayId, bool isFavorite) async {
    if (preferRemote && remoteDataSource != null) {
      try {
        await remoteDataSource!.toggleFavorite(stayId, isFavorite);
      } catch (_) {}
    }
    return mockDataSource.toggleFavorite(stayId, isFavorite);
  }
}
