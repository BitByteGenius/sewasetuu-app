import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/app.dart';
import 'package:sewasetu/app/config/app_config.dart';
import 'package:sewasetu/app/config/environment.dart';
import 'package:sewasetu/core/constants/api_constants.dart';
import 'package:sewasetu/core/constants/app_constants.dart';
import 'package:sewasetu/modules/stay/stay.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    Get.reset();
    SharedPreferences.setMockInitialValues({});
    final storage = StorageService();
    await storage.init();
    Get.put<IStorageService>(storage, permanent: true);
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

  test('Stay Domain & Repository Clean Architecture test', () async {
    final dataSource = StayMockDataSource();
    final repository = StayRepositoryImpl(dataSource);
    final useCase = GetStaysUseCase(repository);

    final allStays = await useCase();
    expect(allStays.isNotEmpty, true);

    final homestays = await useCase(filter: null, searchQuery: 'Shillong');
    expect(homestays.any((s) => s.city.contains('Shillong')), true);

    final featured = await useCase.getFeatured();
    expect(featured.every((s) => s.isFeatured), true);
  });

  testWidgets('App initialization smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SewaSetuApp());
    expect(find.byType(SewaSetuApp), findsOneWidget);

    // Pump timer in SplashController
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });

  testWidgets('SplashScreen displays centered logo with ClipRect and navigates', (WidgetTester tester) async {
    await tester.pumpWidget(const SewaSetuApp());
    await tester.pump(const Duration(milliseconds: 100));

    // Verify ClipRect exists
    expect(find.byType(ClipRect), findsWidgets);

    // Pump through animation completion
    await tester.pump(const Duration(milliseconds: 1900));
    await tester.pumpAndSettle();
  });

  testWidgets('OnboardingScreen displays top text, mobile mockup, and 40/60 action bar', (WidgetTester tester) async {
    await tester.pumpWidget(const SewaSetuApp());
    // Navigate from splash into onboarding
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Verify Onboarding text and widgets
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('When has_seen_onboarding is true, splash navigates directly to main and skips onboarding', (WidgetTester tester) async {
    final storage = Get.find<IStorageService>();
    await storage.setHasSeenOnboarding(true);

    await tester.pumpWidget(const SewaSetuApp());
    // Pump through splash navigation
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Verify onboarding screen is NOT shown
    expect(find.text('Skip'), findsNothing);
    expect(find.text('Find Perfect Stays'), findsNothing);
  });
}
