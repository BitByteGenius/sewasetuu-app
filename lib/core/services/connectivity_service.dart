import 'package:get/get.dart';

/// Connectivity service tracking network availability.
class ConnectivityService extends GetxService {
  final RxBool isOnline = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Default online in simulation; easily wired with connectivity_plus
    isOnline.value = true;
  }
}
