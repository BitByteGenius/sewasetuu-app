import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';

import '../electrician/bindings/electrician_binding.dart';
import '../electrician/screen/carpenter_screen.dart';
import '../electrician/screen/electrician_screen.dart';
import '../electrician/screen/plumbing_screen.dart';
import '../home_cleaning/bindings/home_cleaning_binding.dart';
import '../home_cleaning/screens/home_cleaning_screen.dart';
import '../home_cleaning/screens/kitchen_cleaning_screen.dart';
import '../home_screen/bindings/services_binding.dart';
import '../home_screen/screens/instant_services_navigation_shell.dart';
import '../home_screen/screens/services_screen.dart';
import '../common_widgets/my_cart_widgets.dart';

/// Centralized route definitions and GetPage array for the Home Services module.
/// Decouples navigation routing from screens and provides documented entry points.
abstract class ServicePageRoutes {
  /// Primary Home Services Marketplace Screen (`/services`)
  static const String services = AppRoutes.services;

  /// Electrician Services Detail Screen (`/services/electrician`)
  static const String electrician = AppRoutes.electrician;

  /// Plumbing Services Detail Screen (`/services/plumbing`)
  static const String plumbing = AppRoutes.plumbing;

  /// Carpentry Services Detail Screen (`/services/carpenter`)
  static const String carpenter = AppRoutes.carpenter;

  /// Home Cleaning Overview Screen (`/services/home-cleaning`)
  static const String homeCleaning = '/services/home-cleaning';

  /// Kitchen Cleaning Primary Detail Screen (`/services/kitchen-cleaning`)
  static const String kitchenCleaning = '/services/kitchen-cleaning';

  /// Instant Services Navigation Shell (`/services/instant`)
  static const String instantServices = '/services/instant';

  /// My Cart & Add-ons Checkout Screen (`/services/cart`)
  static const String myCart = '/services/cart';

  /// Modular GetPage definitions for Home Services navigation routing
  static final List<GetPage> routes = [
    GetPage(
      name: services,
      page: () => const ServicesScreen(),
      binding: ServicesBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: electrician,
      page: () => const ElectricianScreen(),
      binding: ElectricianBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: plumbing,
      page: () => const PlumbingScreen(),
      binding: PlumbingBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: carpenter,
      page: () => const CarpenterScreen(),
      binding: CarpenterBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: homeCleaning,
      page: () => const HomeCleaningScreen(),
      binding: HomeCleaningBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: kitchenCleaning,
      page: () => const KitchenCleaningScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: instantServices,
      page: () => const InstantServicesNavigationShell(
        discoverView: ServicesScreen(),
      ),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: myCart,
      page: () => const MyCartWidgets(),
      transition: Transition.downToUp,
    ),
  ];
}
