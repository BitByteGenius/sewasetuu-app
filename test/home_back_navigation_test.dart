import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/config/app_config.dart';
import 'package:sewasetu/app/config/environment.dart';
import 'package:sewasetu/core/constants/api_constants.dart';
import 'package:sewasetu/core/constants/app_constants.dart';
import 'package:sewasetu/modules/home/bindings/home_binding.dart';
import 'package:sewasetu/modules/home/controllers/home_controller.dart';
import 'package:sewasetu/modules/home/screens/home_screen.dart';
import 'package:sewasetu/modules/rental/controllers/rental_navigation_controller.dart';
import 'package:sewasetu/modules/shop/controllers/shop_navigation_controller.dart';
import 'package:sewasetu/modules/stay/controllers/stay_navigation_controller.dart';
import 'package:sewasetu/modules/trips/controllers/trips_navigation_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    Get.reset();
    SharedPreferences.setMockInitialValues({});
    AppConfig.initialize(
      appName: AppConstants.appName,
      apiBaseUrl: ApiConstants.baseUrl,
      environment: Environment.dev,
      enableLogging: false,
    );
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('Bottom navigation back button behavior: Tab 2/3/4 moves to Tab 1, nested screens pop first', (tester) async {
    HomeBinding().dependencies();

    await tester.pumpWidget(
      const GetMaterialApp(
        home: HomeScreen(),
      ),
    );
    await tester.pump();

    final homeCtrl = Get.find<HomeController>();
    final stayNav = Get.find<StayNavigationController>();
    final tripsNav = Get.find<TripsNavigationController>();
    final shopNav = Get.find<ShopNavigationController>();
    final rentalNav = Get.find<RentalNavigationController>();

    // 1. Initial State: Tab 1 (Explore, index 0). PopScope canPop is true.
    expect(stayNav.selectedIndex.value, 0);
    PopScope popScope = tester.widget<PopScope>(find.byType(PopScope));
    expect(popScope.canPop, true);

    // 2. Switch to Tab 2 (Search, index 1)
    stayNav.changeTab(1);
    await tester.pump();
    expect(stayNav.selectedIndex.value, 1);
    popScope = tester.widget<PopScope>(find.byType(PopScope));
    expect(popScope.canPop, false);

    // System back on Tab 2 -> moves to Tab 1
    await tester.binding.handlePopRoute();
    await tester.pump();
    expect(stayNav.selectedIndex.value, 0);
    popScope = tester.widget<PopScope>(find.byType(PopScope));
    expect(popScope.canPop, true);

    // 3. Switch to Tab 3 (Saved, index 2)
    stayNav.changeTab(2);
    await tester.pump();
    expect(stayNav.selectedIndex.value, 2);
    popScope = tester.widget<PopScope>(find.byType(PopScope));
    expect(popScope.canPop, false);

    // System back on Tab 3 -> moves to Tab 1
    await tester.binding.handlePopRoute();
    await tester.pump();
    expect(stayNav.selectedIndex.value, 0);
    popScope = tester.widget<PopScope>(find.byType(PopScope));
    expect(popScope.canPop, true);

    // 4. Switch to Tab 4 (Bookings, index 3)
    stayNav.changeTab(3);
    await tester.pump();
    expect(stayNav.selectedIndex.value, 3);
    popScope = tester.widget<PopScope>(find.byType(PopScope));
    expect(popScope.canPop, false);

    // System back on Tab 4 -> moves to Tab 1
    await tester.binding.handlePopRoute();
    await tester.pump();
    expect(stayNav.selectedIndex.value, 0);
    popScope = tester.widget<PopScope>(find.byType(PopScope));
    expect(popScope.canPop, true);

    // 5. Nested screen behavior:
    // When on Tab 2, push a nested screen.
    stayNav.changeTab(1);
    await tester.pump();
    expect(stayNav.selectedIndex.value, 1);

    // Push a nested screen (e.g. Property Details)
    Get.to<void>(() => const Scaffold(body: Text('Property Details Screen')));
    await tester.pumpAndSettle();
    expect(find.text('Property Details Screen'), findsOneWidget);

    // First back pops the nested screen, tab remains at Tab 2
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Property Details Screen'), findsNothing);
    expect(stayNav.selectedIndex.value, 1);

    // Next back at tab root moves from Tab 2 to Tab 1
    await tester.binding.handlePopRoute();
    await tester.pump();
    expect(stayNav.selectedIndex.value, 0);
    popScope = tester.widget<PopScope>(find.byType(PopScope));
    expect(popScope.canPop, true);

    // 6. Test Shop Service: Tab 2 (Cart) -> Back moves to Tab 1 (Home)
    homeCtrl.selectService(HomeService.shop);
    await tester.pump();
    shopNav.changeTab(2); // Cart
    await tester.pump();
    expect(shopNav.currentIndex.value, 2);
    popScope = tester.widget<PopScope>(find.byType(PopScope));
    expect(popScope.canPop, false);

    await tester.binding.handlePopRoute();
    await tester.pump();
    expect(shopNav.currentIndex.value, 0);
    popScope = tester.widget<PopScope>(find.byType(PopScope));
    expect(popScope.canPop, true);

    // 7. Test Trips Service: Tab 1 (Destinations) -> Back moves to Tab 1 (Discover)
    homeCtrl.selectService(HomeService.trips);
    await tester.pump();
    tripsNav.changeTab(1);
    await tester.pump();
    expect(tripsNav.selectedIndex.value, 1);
    popScope = tester.widget<PopScope>(find.byType(PopScope));
    expect(popScope.canPop, false);

    await tester.binding.handlePopRoute();
    await tester.pump();
    expect(tripsNav.selectedIndex.value, 0);
    popScope = tester.widget<PopScope>(find.byType(PopScope));
    expect(popScope.canPop, true);

    // 8. Test Rental Service: Tab 2 (Bookings) -> Back moves to Tab 1 (Explore)
    homeCtrl.selectService(HomeService.rental);
    await tester.pump();
    rentalNav.changeTab(2);
    await tester.pump();
    expect(rentalNav.currentIndex.value, 2);
    popScope = tester.widget<PopScope>(find.byType(PopScope));
    expect(popScope.canPop, false);

    await tester.binding.handlePopRoute();
    await tester.pump();
    expect(rentalNav.currentIndex.value, 0);
    popScope = tester.widget<PopScope>(find.byType(PopScope));
    expect(popScope.canPop, true);

    // Drain timers
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
  });
}
