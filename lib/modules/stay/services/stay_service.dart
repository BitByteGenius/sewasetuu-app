import 'dart:async';
import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/data/datasources/stay_mock_datasource.dart';
import 'package:sewasetu/modules/stay/data/repositories/stay_repository_impl.dart';
import 'package:sewasetu/modules/stay/domain/repositories/stay_repository.dart';
import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/modules/stay/models/review_model.dart';
import 'package:sewasetu/modules/stay/models/stay_filter_criteria.dart';


/// Facade Service managing Stay operations, delegating to [IStayRepository].
/// Maintains backwards compatibility for external consumers (e.g. HomeController, WishlistController).
class StayService {
  late final IStayRepository _repository;

  StayService({IStayRepository? repository}) {
    if (repository != null) {
      _repository = repository;
    } else if (Get.isRegistered<IStayRepository>()) {
      _repository = Get.find<IStayRepository>();
    } else {
      _repository = StayRepositoryImpl(mockDataSource: StayMockDataSourceImpl());
    }
  }

  Future<List<PropertyModel>> getStays({
    StayFilterCriteria? filter,
    String? searchQuery,
  }) {
    return _repository.getStays(filter: filter, searchQuery: searchQuery);
  }

  Future<List<PropertyModel>> getSavedStays() {
    return _repository.getSavedStays();
  }

  Future<List<PropertyModel>> getFeaturedStays() {
    return _repository.getFeaturedStays();
  }

  Future<List<PropertyModel>> getNearbyStays({required String city}) {
    return _repository.getNearbyStays(city: city);
  }

  Future<PropertyModel> getStayById(String id) {
    return _repository.getStayById(id);
  }

  Future<List<ReviewModel>> getStayReviews(String stayId) {
    return _repository.getStayReviews(stayId);
  }

  Future<bool> toggleFavorite(String stayId, [bool? currentFavorite]) {
    return _repository.toggleFavorite(stayId, currentFavorite ?? false);
  }
}

// ==============================================================================
// DOMAIN USE CASES
// ==============================================================================

class GetStaysUseCase {
  final IStayRepository repository;
  GetStaysUseCase(this.repository);

  Future<List<PropertyModel>> call({
    StayFilterCriteria? filter,
    String? searchQuery,
  }) =>
      repository.getStays(filter: filter, searchQuery: searchQuery);

  Future<List<PropertyModel>> getFeatured() => repository.getFeaturedStays();
  Future<List<PropertyModel>> getNearby(String city) =>
      repository.getNearbyStays(city: city);
  Future<bool> toggleFavorite(String stayId, bool isFavorite) =>
      repository.toggleFavorite(stayId, isFavorite);
}

class GetStayDetailsUseCase {
  final IStayRepository repository;
  GetStayDetailsUseCase(this.repository);

  Future<PropertyModel> getDetails(String id) => repository.getStayById(id);
  Future<List<ReviewModel>> getReviews(String id) =>
      repository.getStayReviews(id);
}

class SearchStaysUseCase {
  final IStayRepository repository;
  SearchStaysUseCase(this.repository);

  Future<List<PropertyModel>> call(String query) =>
      repository.getStays(searchQuery: query);
}
