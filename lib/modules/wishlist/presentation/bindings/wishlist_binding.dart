import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/property/domain/usecases/get_stays_usecase.dart';
import 'package:sewasetu/modules/wishlist/presentation/controllers/wishlist_controller.dart';

class WishlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WishlistController>(
      () => WishlistController(getStaysUseCase: Get.find<GetStaysUseCase>()),
    );
  }
}
