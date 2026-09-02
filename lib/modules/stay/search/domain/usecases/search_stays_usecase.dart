import 'package:sewasetu/modules/stay/property/domain/entities/stay_entity.dart';
import 'package:sewasetu/modules/stay/property/domain/repositories/stay_repository.dart';
import 'package:sewasetu/modules/stay/filter/domain/entities/stay_filter_criteria.dart';

class SearchStaysUseCase {
  final IStayRepository repository;

  SearchStaysUseCase(this.repository);

  Future<List<StayEntity>> call(String query, {StayFilterCriteria? filter}) async {
    return await repository.getStays(
      searchQuery: query,
      filter: filter,
    );
  }
}
