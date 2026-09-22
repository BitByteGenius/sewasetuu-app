import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/config/app_config.dart';
import 'package:sewasetu/app/config/environment.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/core/constants/api_constants.dart';
import 'package:sewasetu/core/constants/app_constants.dart';
import 'package:sewasetu/core/storage/storage_service.dart';
import 'package:sewasetu/modules/splash/controllers/splash_controller.dart';
import 'package:sewasetu/modules/splash/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    Get.reset();
    SharedPreferences.setMockInitialValues({});
    final storage = StorageService();
    await storage.init();
    Get.put<IStorageService>(storage, permanent: true);
    Get.put<SplashController>(SplashController(storage));
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

  Widget createTestWidget() {
    return GetMaterialApp(
      initialRoute: AppRoutes.splash,
      getPages: [
        GetPage(
          name: AppRoutes.splash,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: AppRoutes.onboarding,
          page: () => const Scaffold(body: Center(child: Text('Onboarding Screen'))),
        ),
      ],
    );
  }

  testWidgets('SplashScreen renders ClipRect, Image, and handles fade-in on mobile viewport', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(createTestWidget());

    // Initial frame
    await tester.pump(const Duration(milliseconds: 100));

    // Verify ClipRect exists
    expect(find.byType(ClipRect), findsWidgets);

    // Verify Image asset exists
    expect(find.byType(Image), findsOneWidget);

    // Verify Scaffold background matches brand light-green
    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, const Color(0xFFB4E07D));

    // Pump through animation and timer completion to navigate
    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Onboarding Screen'), findsOneWidget);
  });

  testWidgets('SplashScreen adapts gracefully on tablet/wide viewport with ConstrainedBox', (WidgetTester tester) async {
    // iPad / tablet dimensions (1600 x 2000) -> aspect ratio > 0.65
    tester.view.physicalSize = const Size(1600, 2000);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(createTestWidget());

    await tester.pump(const Duration(milliseconds: 100));

    // Verify ConstrainedBox is used for wide screens
    expect(find.byType(ConstrainedBox), findsWidgets);
    expect(find.byType(ClipRect), findsWidgets);
    expect(find.byType(Image), findsOneWidget);

    // Pump through completion
    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Onboarding Screen'), findsOneWidget);
  });

  testWidgets('Tapping anywhere triggers immediate navigation callback', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    await tester.pump(const Duration(milliseconds: 100));

    // Tap on splash screen
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 2000));
    expect(find.text('Onboarding Screen'), findsOneWidget);
  });
}
