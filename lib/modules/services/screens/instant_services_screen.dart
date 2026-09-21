import 'package:flutter/material.dart';
import 'package:sewasetu/modules/services/screens/instant_services_navigation_shell.dart';
import 'package:sewasetu/modules/services/screens/services_screen.dart';

/// Primary screen wrapper for the Instant Services module within the Home
/// service switcher's IndexedStack.
///
/// Wraps the existing [ServicesScreen] inside the [InstantServicesNavigationShell],
/// providing the module-specific bottom navigation bar with independent tab state.
class InstantServicesScreen extends StatelessWidget {
  const InstantServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InstantServicesNavigationShell(
      discoverView: ServicesScreen(),
    );
  }
}
