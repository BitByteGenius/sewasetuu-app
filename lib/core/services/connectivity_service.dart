import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';

/// Banner type for custom floating top notification.
enum ConnectivityBannerType {
  offline,
  backOnline,
}

/// Core Connectivity Service tracking network availability, managing top floating
/// banners with a 10-second timeout, and handling safe navigation transitions.
class ConnectivityService extends GetxService {
  /// Whether internet connection is currently available.
  final RxBool isOnline = true.obs;

  /// Whether the top floating banner is currently visible.
  final RxBool showBanner = false.obs;

  /// Current visual theme of the floating banner (offline vs backOnline).
  final Rx<ConnectivityBannerType> bannerType = ConnectivityBannerType.offline.obs;

  Timer? _offlineTimer;
  Timer? _dismissTimer;
  Timer? _pollingTimer;

  @override
  void onInit() {
    super.onInit();
    // Default online state
    isOnline.value = true;
    _startPeriodicMonitoring();
  }

  @override
  void onClose() {
    _offlineTimer?.cancel();
    _dismissTimer?.cancel();
    _pollingTimer?.cancel();
    super.onClose();
  }

  /// Starts background network probing every 5 seconds.
  void _startPeriodicMonitoring() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      checkConnection();
    });
  }

  /// Actively checks internet availability via DNS lookup.
  Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 3));
      final hasConnection = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      setOnline(hasConnection);
      return hasConnection;
    } on SocketException catch (_) {
      setOnline(false);
      return false;
    } on TimeoutException catch (_) {
      setOnline(false);
      return false;
    } catch (_) {
      // In web or restricted environments, preserve current status
      return isOnline.value;
    }
  }

  /// Updates online status and transitions state cleanly.
  void setOnline(bool online) {
    if (online == isOnline.value) return;

    if (!online) {
      _handleConnectionLost();
    } else {
      _handleConnectionRestored();
    }
  }

  /// Triggered when network connection drops.
  void _handleConnectionLost() {
    isOnline.value = false;
    bannerType.value = ConnectivityBannerType.offline;
    showBanner.value = true;

    // Reset timers
    _dismissTimer?.cancel();
    _offlineTimer?.cancel();

    // 10-second timer: If still offline after 10s, dismiss banner and route to NoInternetScreen
    _offlineTimer = Timer(const Duration(seconds: 10), () {
      if (!isOnline.value) {
        showBanner.value = false;
        _navigateToNoInternetScreen();
      }
    });
  }

  /// Triggered when connection is recovered.
  void _handleConnectionRestored() {
    isOnline.value = true;
    _offlineTimer?.cancel();
    _offlineTimer = null;

    // If currently on NoInternetScreen, safely pop back to the previous screen
    if (Get.currentRoute == AppRoutes.noInternet) {
      if (Get.key.currentState?.canPop() ?? false) {
        Get.back();
      } else {
        Get.offAllNamed(AppRoutes.main);
      }
    }

    // Display "Back Online" banner from top
    bannerType.value = ConnectivityBannerType.backOnline;
    showBanner.value = true;

    _dismissTimer?.cancel();
    _dismissTimer = Timer(const Duration(milliseconds: 2500), () {
      showBanner.value = false;
    });
  }

  /// Navigates to dedicated No Internet Screen if not already present.
  void _navigateToNoInternetScreen() {
    if (Get.currentRoute != AppRoutes.noInternet) {
      Get.toNamed(AppRoutes.noInternet);
    }
  }

  /// Manually dismisses the floating banner.
  void dismissBanner() {
    showBanner.value = false;
  }
}
