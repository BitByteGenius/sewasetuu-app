import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/services/stay_service.dart';
import '../controllers/wishlist_controller.dart';

class WishlistBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<StayService>()) {
      Get.lazyPut<StayService>(() => StayService());
    }
    Get.lazyPut<WishlistController>(() => WishlistController(), fenix: true);
  }
}
