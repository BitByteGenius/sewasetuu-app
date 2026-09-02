import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/property/data/datasources/stay_mock_datasource.dart';
import 'package:sewasetu/modules/stay/property/data/repositories/stay_repository_impl.dart';
import 'package:sewasetu/modules/stay/property/domain/repositories/stay_repository.dart';
import 'package:sewasetu/modules/stay/property/domain/usecases/get_stays_usecase.dart';
import 'package:sewasetu/modules/stay/property/presentation/controllers/stay_list_controller.dart';

/// Bindings for Stay listing feature (resolves dependencies on-demand)
class StayListBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<IStayDataSource>()) {
      Get.lazyPut<IStayDataSource>(() => StayMockDataSource());
    }
    if (!Get.isRegistered<IStayRepository>()) {
      Get.lazyPut<IStayRepository>(() => StayRepositoryImpl(Get.find<IStayDataSource>()));
    }

    Get.lazyPut<GetStaysUseCase>(() => GetStaysUseCase(Get.find<IStayRepository>()));
    Get.lazyPut<StayListController>(
      () => StayListController(getStaysUseCase: Get.find<GetStaysUseCase>()),
    );
  }
}
