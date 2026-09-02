import 'package:get/get.dart';
import 'package:sewasetu/core/services/location_service.dart';
import 'package:sewasetu/modules/stay/property/data/datasources/stay_mock_datasource.dart';
import 'package:sewasetu/modules/stay/property/data/repositories/stay_repository_impl.dart';
import 'package:sewasetu/modules/stay/property/domain/repositories/stay_repository.dart';
import 'package:sewasetu/modules/stay/property/domain/usecases/get_stays_usecase.dart';
import 'package:sewasetu/modules/stay/property/presentation/controllers/stay_list_controller.dart';
import 'package:sewasetu/modules/booking/presentation/controllers/booking_controller.dart';
import 'package:sewasetu/modules/wishlist/presentation/controllers/wishlist_controller.dart';
import 'package:sewasetu/modules/profile/presentation/controllers/profile_controller.dart';
import 'package:sewasetu/modules/home/presentation/controllers/home_controller.dart';

/// Bindings for Home & Main Navigation Shell
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Stay Core Dependencies
    if (!Get.isRegistered<IStayDataSource>()) {
      Get.lazyPut<IStayDataSource>(() => StayMockDataSource(), fenix: true);
    }
    if (!Get.isRegistered<IStayRepository>()) {
      Get.lazyPut<IStayRepository>(
        () => StayRepositoryImpl(Get.find<IStayDataSource>()),
        fenix: true,
      );
    }
    if (!Get.isRegistered<GetStaysUseCase>()) {
      Get.lazyPut<GetStaysUseCase>(
        () => GetStaysUseCase(Get.find<IStayRepository>()),
        fenix: true,
      );
    }

    // Controllers for Shell Tabs
    Get.lazyPut<HomeController>(
      () => HomeController(
        getStaysUseCase: Get.find<GetStaysUseCase>(),
        locationService: Get.find<LocationService>(),
      ),
    );

    Get.lazyPut<StayListController>(
      () => StayListController(getStaysUseCase: Get.find<GetStaysUseCase>()),
      fenix: true,
    );

    Get.lazyPut<BookingController>(() => BookingController(), fenix: true);
    Get.lazyPut<WishlistController>(
      () => WishlistController(getStaysUseCase: Get.find<GetStaysUseCase>()),
      fenix: true,
    );
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}
