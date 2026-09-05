import 'package:get/get.dart';
import '../models/vehicle_model.dart';

/// Controller managing saved / favorited vehicles with reactive state.
class RentalFavoritesController extends GetxController {
  final RxSet<String> favoriteIds = <String>{'veh_thar_01', 'veh_himalayan_07'}.obs;

  bool isFavorite(String vehicleId) {
    return favoriteIds.contains(vehicleId);
  }

  void toggleFavorite(VehicleModel vehicle) {
    if (favoriteIds.contains(vehicle.id)) {
      favoriteIds.remove(vehicle.id);
      Get.snackbar(
        'Removed from Wishlist',
        '${vehicle.fullName} removed from your saved rides.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } else {
      favoriteIds.add(vehicle.id);
      Get.snackbar(
        'Saved to Wishlist',
        '${vehicle.fullName} saved for quick access.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
