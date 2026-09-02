import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/app.dart';
import 'package:sewasetu/app/config/app_config.dart';
import 'package:sewasetu/app/config/environment.dart';
import 'package:sewasetu/core/constants/api_constants.dart';
import 'package:sewasetu/core/constants/app_constants.dart';
import 'package:sewasetu/modules/stay/property/data/datasources/stay_mock_datasource.dart';
import 'package:sewasetu/modules/stay/property/data/repositories/stay_repository_impl.dart';
import 'package:sewasetu/modules/stay/property/domain/usecases/get_stays_usecase.dart';
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
}
