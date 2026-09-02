import 'package:sewasetu/modules/stay/property/domain/entities/stay_entity.dart';
import 'package:sewasetu/modules/stay/property/domain/repositories/stay_repository.dart';
import 'package:sewasetu/modules/stay/review/domain/entities/review_entity.dart';

class GetStayDetailsUseCase {
  final IStayRepository repository;

  GetStayDetailsUseCase(this.repository);

  Future<StayEntity> getDetails(String id) async {
    return await repository.getStayById(id);
  }

  Future<List<StayReviewEntity>> getReviews(String stayId) async {
    return await repository.getStayReviews(stayId);
  }
}
