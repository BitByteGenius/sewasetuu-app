import 'package:get/get.dart';
import '../../modules/auth/presentation/bindings/auth_binding.dart';
import '../../modules/auth/presentation/pages/login_page.dart';
import '../../modules/booking/presentation/bindings/booking_binding.dart';
import '../../modules/booking/presentation/pages/booking_list_page.dart';
import '../../modules/home/presentation/bindings/home_binding.dart';
import '../../modules/home/presentation/pages/home_page.dart';
import '../../modules/home/presentation/pages/main_navigation_shell.dart';
import '../../modules/notifications/presentation/pages/notifications_page.dart';
import '../../modules/onboarding/presentation/bindings/onboarding_binding.dart';
import '../../modules/onboarding/presentation/pages/onboarding_page.dart';
import '../../modules/payment/presentation/pages/payment_methods_page.dart';
import '../../modules/profile/presentation/bindings/profile_binding.dart';
import '../../modules/profile/presentation/pages/profile_page.dart';
import '../../modules/rentals/presentation/pages/rentals_page.dart';
import '../../modules/services/presentation/pages/services_page.dart';
import '../../modules/splash/presentation/bindings/splash_binding.dart';
import '../../modules/splash/presentation/pages/splash_page.dart';
import '../../modules/stay/property/presentation/bindings/stay_list_binding.dart';
import '../../modules/stay/property/presentation/pages/stay_list_page.dart';
import '../../modules/stay/property_details/presentation/bindings/property_details_binding.dart';
import '../../modules/stay/property_details/presentation/pages/property_details_page.dart';
import '../../modules/stay/search/presentation/bindings/search_binding.dart';
import '../../modules/stay/search/presentation/pages/stay_search_page.dart';
import '../../modules/trips/presentation/pages/trips_page.dart';
import '../../modules/wishlist/presentation/bindings/wishlist_binding.dart';
import '../../modules/wishlist/presentation/pages/wishlist_page.dart';
import 'app_routes.dart';

/// Centralized GetPage definitions with bindings and transition animations.
abstract class AppPages {
  static const String initial = AppRoutes.splash;

  static final List<GetPage> routes = [
    // Splash
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Onboarding
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
      transition: Transition.rightToLeftWithFade,
    ),

    // Auth
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
      transition: Transition.rightToLeftWithFade,
    ),

    // Main App Shell (Bottom Navigation)
    GetPage(
      name: AppRoutes.main,
      page: () => const MainNavigationShell(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),

    // Home
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),

    // Stay / Accommodation (Core Module)
    GetPage(
      name: AppRoutes.stayList,
      page: () => const StayListPage(),
      binding: StayListBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.stayDetails,
      page: () => const PropertyDetailsPage(),
      binding: PropertyDetailsBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.staySearch,
      page: () => const StaySearchPage(),
      binding: SearchBinding(),
      transition: Transition.downToUp,
    ),

    // Bookings & Wishlist
    GetPage(
      name: AppRoutes.booking,
      page: () => const BookingListPage(),
      binding: BookingBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.wishlist,
      page: () => const WishlistPage(),
      binding: WishlistBinding(),
      transition: Transition.rightToLeftWithFade,
    ),

    // Profile & Notifications
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsPage(),
      transition: Transition.rightToLeftWithFade,
    ),

    // Secondary Marketplace Modules
    GetPage(
      name: AppRoutes.services,
      page: () => const ServicesPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.rentals,
      page: () => const RentalsPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.trips,
      page: () => const TripsPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => const PaymentMethodsPage(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
