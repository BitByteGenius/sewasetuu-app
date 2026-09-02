import 'package:sewasetu/modules/stay/property/domain/entities/stay_entity.dart';
import 'package:sewasetu/modules/stay/property/domain/repositories/stay_repository.dart';
import 'package:sewasetu/modules/stay/filter/domain/entities/stay_filter_criteria.dart';

class GetStaysUseCase {
  final IStayRepository repository;

  GetStaysUseCase(this.repository);

  Future<List<StayEntity>> call({
    StayFilterCriteria? filter,
    String? searchQuery,
    int page = 1,
  }) async {
    return await repository.getStays(
      filter: filter,
      searchQuery: searchQuery,
      page: page,
    );
  }

  Future<List<StayEntity>> getFeatured() async {
    return await repository.getFeaturedStays();
  }

  Future<List<StayEntity>> getNearby(String city) async {
    return await repository.getNearbyStays(city: city);
  }

  Future<bool> toggleFavorite(String stayId, bool isFavorite) async {
    return await repository.toggleFavorite(stayId, isFavorite);
  }
}
