import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/config/app_config.dart';
import 'package:sewasetu/app/config/environment.dart';
import 'package:sewasetu/core/constants/api_constants.dart';
import 'package:sewasetu/core/constants/app_constants.dart';
import 'package:sewasetu/modules/home/bindings/home_binding.dart';
import 'package:sewasetu/modules/home/controllers/home_controller.dart';
import 'package:sewasetu/modules/home/screens/home_screen.dart';
import 'package:sewasetu/modules/home/widgets/home_location_header_widget.dart';
import 'package:sewasetu/modules/home/widgets/service_tab.dart';
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

  testWidgets('Sticky location header and ServiceTab only visible on Home/Explore/Discover tabs', (tester) async {
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

    // 1. Initial state: Stay on Explore (tab 0)
    expect(homeCtrl.selectedService.value, HomeService.stay);
    expect(stayNav.selectedIndex.value, 0);
    expect(homeCtrl.isMainFeedActive, true);
    expect(find.byType(HomeLocationHeaderWidget), findsOneWidget);
    expect(find.byType(ServiceTab), findsOneWidget);

    // 2. Stay: Switch to Saved (tab 2)
    stayNav.changeTab(2);
    await tester.pump();
    expect(homeCtrl.isMainFeedActive, false);
    expect(find.byType(HomeLocationHeaderWidget), findsNothing);
    expect(find.byType(ServiceTab), findsNothing);

    // 3. Stay: Switch back to Explore (tab 0)
    stayNav.toExplore();
    await tester.pump();
    expect(homeCtrl.isMainFeedActive, true);
    expect(find.byType(HomeLocationHeaderWidget), findsOneWidget);
    expect(find.byType(ServiceTab), findsOneWidget);

    // 4. Switch to Shop service
    homeCtrl.selectService(HomeService.shop);
    await tester.pump();
    expect(shopNav.currentIndex.value, 0);
    expect(homeCtrl.isMainFeedActive, true);
    expect(find.byType(HomeLocationHeaderWidget), findsOneWidget);
    expect(find.byType(ServiceTab), findsOneWidget);

    // 5. Shop: Switch to Cart (tab 2)
    shopNav.changeTab(2);
    await tester.pump();
    expect(homeCtrl.isMainFeedActive, false);
    expect(find.byType(HomeLocationHeaderWidget), findsNothing);
    expect(find.byType(ServiceTab), findsNothing);

    // 6. Shop: Switch back to Home (tab 0)
    shopNav.toHome();
    await tester.pump();
    expect(homeCtrl.isMainFeedActive, true);
    expect(find.byType(HomeLocationHeaderWidget), findsOneWidget);
    expect(find.byType(ServiceTab), findsOneWidget);

    // 7. Switch to Trips: Switch to Destinations (tab 1)
    homeCtrl.selectService(HomeService.trips);
    await tester.pump();
    tripsNav.changeTab(1);
    await tester.pump();
    expect(homeCtrl.isMainFeedActive, false);
    expect(find.byType(HomeLocationHeaderWidget), findsNothing);
    expect(find.byType(ServiceTab), findsNothing);

    // 8. Trips: Switch to Discover (tab 0)
    tripsNav.toDiscover();
    await tester.pump();
    expect(homeCtrl.isMainFeedActive, true);
    expect(find.byType(HomeLocationHeaderWidget), findsOneWidget);
    expect(find.byType(ServiceTab), findsOneWidget);

    // 9. Switch to Rental: Switch to Bookings (tab 2)
    homeCtrl.selectService(HomeService.rental);
    await tester.pump();
    rentalNav.changeTab(2);
    await tester.pump();
    expect(homeCtrl.isMainFeedActive, false);
    expect(find.byType(HomeLocationHeaderWidget), findsNothing);
    expect(find.byType(ServiceTab), findsNothing);

    // 10. Rental: Switch back to Explore (tab 0)
    rentalNav.toExplore();
    await tester.pump();
    expect(homeCtrl.isMainFeedActive, true);
    expect(find.byType(HomeLocationHeaderWidget), findsOneWidget);
    expect(find.byType(ServiceTab), findsOneWidget);

    // Drain pending mock network timers with bounded pump (longest simulated delay is 350ms)
    await tester.pump(const Duration(seconds: 1));
  });
}
