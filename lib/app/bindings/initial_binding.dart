import 'package:get/get.dart';
import 'package:sewasetu/core/network/api_client.dart';
import 'package:sewasetu/core/services/connectivity_service.dart';
import 'package:sewasetu/core/services/location_service.dart';
import 'package:sewasetu/core/services/notification_service.dart';
import 'package:sewasetu/core/storage/storage_service.dart';

/// Global initial binding for persistent Core infrastructure singletons.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Storage Service (Persistent)
    final IStorageService storageService = Get.isRegistered<IStorageService>()
        ? Get.find<IStorageService>()
        : Get.put<IStorageService>(StorageService(), permanent: true);

    // 2. HTTP Network Client
    if (!Get.isRegistered<IApiClient>()) {
      Get.put<IApiClient>(ApiClient(storageService), permanent: true);
    }

    // 3. System & Feature Services
    if (!Get.isRegistered<ConnectivityService>()) {
      Get.put<ConnectivityService>(ConnectivityService(), permanent: true);
    }
    if (!Get.isRegistered<LocationService>()) {
      Get.put<LocationService>(LocationService(storageService), permanent: true);
    }
    if (!Get.isRegistered<NotificationService>()) {
      Get.put<NotificationService>(NotificationService(), permanent: true);
    }
  }
}
