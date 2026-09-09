import 'package:get/get.dart';

/// Navigation controller managing tab switching for the Shop module
class ShopNavigationController extends GetxController {
  static ShopNavigationController get to => Get.find<ShopNavigationController>();

  /// Currently active navigation tab index
  /// 0: Home (Bazaar / Products discovery feed)
  /// 1: Categories (States & regional craft hubs)
  /// 2: Cart (Shopping bag with live badge)
  /// 3: Orders (Order history & tracking)
  final RxInt currentIndex = 0.obs;

  void changeTab(int index) {
    if (index >= 0 && index <= 3) {
      currentIndex.value = index;
    }
  }

  void toHome() => changeTab(0);
  void toCategories() => changeTab(1);
  void toCart() => changeTab(2);
  void toOrders() => changeTab(3);
}
