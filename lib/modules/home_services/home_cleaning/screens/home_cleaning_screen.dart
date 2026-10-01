import 'package:flutter/material.dart';
import 'package:sewasetu/modules/home_services/home_cleaning/widgets/home_cleaning_bottom_sheet.dart';
import 'package:sewasetu/shared/widgets/app_bar/app_bar.dart';

/// Screen component for Home Cleaning module.
/// Can be pushed as a dedicated route or invoked via [showAsBottomSheet].
class HomeCleaningScreen extends StatelessWidget {
  const HomeCleaningScreen({super.key});

  /// Static helper to trigger the modal bottom sheet
  static Future<T?> showAsBottomSheet<T>(BuildContext context) {
    return HomeCleaningBottomSheet.show<T>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SewaAppBar(
        titleText: 'Home Cleaning',
        showBackButton: true,
      ),
      body: const SingleChildScrollView(
        child: HomeCleaningBottomSheetContent(),
      ),
    );
  }
}
