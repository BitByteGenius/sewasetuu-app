import 'package:get/get.dart';

/// Navigation controller managing tab selection for the Tours & Trips module
class TripsNavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void changeTab(int index) {
    if (index >= 0 && index <= 3) {
      selectedIndex.value = index;
    }
  }

  void toDiscover() => changeTab(0);
  void toDestinations() => changeTab(1);
  void toMyTrips() => changeTab(2);
  void toSaved() => changeTab(3);
}
