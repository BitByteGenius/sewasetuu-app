import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/property/data/datasources/stay_mock_datasource.dart';
import 'package:sewasetu/modules/stay/property/data/repositories/stay_repository_impl.dart';
import 'package:sewasetu/modules/stay/property/domain/repositories/stay_repository.dart';
import 'package:sewasetu/modules/stay/property_details/domain/usecases/get_stay_details_usecase.dart';
import 'package:sewasetu/modules/stay/property_details/presentation/controllers/property_details_controller.dart';

/// Bindings for Property Details feature
class PropertyDetailsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<IStayDataSource>()) {
      Get.lazyPut<IStayDataSource>(() => StayMockDataSource());
    }
    if (!Get.isRegistered<IStayRepository>()) {
      Get.lazyPut<IStayRepository>(() => StayRepositoryImpl(Get.find<IStayDataSource>()));
    }

    Get.lazyPut<GetStayDetailsUseCase>(() => GetStayDetailsUseCase(Get.find<IStayRepository>()));
    Get.lazyPut<PropertyDetailsController>(
      () => PropertyDetailsController(getStayDetailsUseCase: Get.find<GetStayDetailsUseCase>()),
    );
  }
}
