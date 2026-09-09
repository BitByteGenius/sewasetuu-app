import 'package:flutter/material.dart';
import 'home_screen.dart';

/// Main application entry shell displaying HomeScreen.
///
/// The older generic bottom navigation bar has been removed in favor of
/// service-specific, premium navigation bars defined inside each individual
/// service module (Stay, Tours & Trips, Shop, and Vehicle Rental).
class MainNavigationShell extends StatelessWidget {
  const MainNavigationShell({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
