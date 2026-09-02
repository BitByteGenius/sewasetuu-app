import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/property/data/datasources/stay_mock_datasource.dart';
import 'package:sewasetu/modules/stay/property/data/repositories/stay_repository_impl.dart';
import 'package:sewasetu/modules/stay/property/domain/repositories/stay_repository.dart';
import 'package:sewasetu/modules/stay/search/domain/usecases/search_stays_usecase.dart';
import 'package:sewasetu/modules/stay/search/presentation/controllers/stay_search_controller.dart';

/// Bindings for Stay Search Feature
class SearchBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<IStayDataSource>()) {
      Get.lazyPut<IStayDataSource>(() => StayMockDataSource());
    }
    if (!Get.isRegistered<IStayRepository>()) {
      Get.lazyPut<IStayRepository>(() => StayRepositoryImpl(Get.find<IStayDataSource>()));
    }

    Get.lazyPut<SearchStaysUseCase>(() => SearchStaysUseCase(Get.find<IStayRepository>()));
    Get.lazyPut<StaySearchController>(
      () => StaySearchController(searchStaysUseCase: Get.find<SearchStaysUseCase>()),
    );
  }
}
