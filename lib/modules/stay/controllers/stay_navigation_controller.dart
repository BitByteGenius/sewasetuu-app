import 'package:get/get.dart';

/// Navigation controller managing tab selection for the Stay module
class StayNavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void changeTab(int index) {
    if (index >= 0 && index <= 3) {
      selectedIndex.value = index;
    }
  }

  void toExplore() => changeTab(0);
  void toSearch() => changeTab(1);
  void toSaved() => changeTab(2);
  void toBookings() => changeTab(3);
}
