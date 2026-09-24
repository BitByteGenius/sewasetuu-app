import 'package:get/get.dart';
import 'package:sewasetu/core/network/api_client.dart';
import 'package:sewasetu/modules/stay/controllers/stay_controller.dart';
import 'package:sewasetu/modules/stay/data/datasources/stay_mock_datasource.dart';
import 'package:sewasetu/modules/stay/data/datasources/stay_remote_datasource.dart';
import 'package:sewasetu/modules/stay/data/repositories/stay_repository_impl.dart';
import 'package:sewasetu/modules/stay/domain/repositories/stay_repository.dart';
import 'package:sewasetu/modules/stay/services/stay_service.dart';

/// Bindings for Stay Listing and Feed
class StayBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<IStayMockDataSource>()) {
      Get.lazyPut<IStayMockDataSource>(() => StayMockDataSourceImpl(), fenix: true);
    }
    if (Get.isRegistered<IApiClient>() && !Get.isRegistered<IStayRemoteDataSource>()) {
      Get.lazyPut<IStayRemoteDataSource>(
        () => StayRemoteDataSourceImpl(Get.find<IApiClient>()),
        fenix: true,
      );
    }
    if (!Get.isRegistered<IStayRepository>()) {
      Get.lazyPut<IStayRepository>(
        () => StayRepositoryImpl(
          remoteDataSource: Get.isRegistered<IStayRemoteDataSource>()
              ? Get.find<IStayRemoteDataSource>()
              : null,
          mockDataSource: Get.find<IStayMockDataSource>(),
        ),
        fenix: true,
      );
    }
    if (!Get.isRegistered<StayService>()) {
      Get.lazyPut<StayService>(
        () => StayService(repository: Get.find<IStayRepository>()),
        fenix: true,
      );
    }
    Get.lazyPut<StayController>(
      () => StayController(stayRepository: Get.find<IStayRepository>()),
    );
  }
}

typedef StayListBinding = StayBinding;
