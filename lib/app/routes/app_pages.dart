import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/modules/auth/auth.dart';
import 'package:sewasetu/modules/bookings/bookings.dart';
import 'package:sewasetu/modules/home/home.dart';
import 'package:sewasetu/modules/notifications/notifications.dart';
import 'package:sewasetu/modules/onboarding/onboarding.dart';
import 'package:sewasetu/modules/payment/payment.dart';
import 'package:sewasetu/modules/profile/profile.dart';
import 'package:sewasetu/modules/rental/rental.dart';
import 'package:sewasetu/modules/services/services.dart';
import 'package:sewasetu/modules/shop/shop.dart';
import 'package:sewasetu/modules/splash/splash.dart';
import 'package:sewasetu/modules/stay/stay.dart';
import 'package:sewasetu/modules/trips/trips.dart';
import 'package:sewasetu/modules/wishlist/wishlist.dart';

/// Centralized GetPage definitions with bindings and transition animations
abstract class AppPages {
  static const String initial = AppRoutes.splash;

  static final List<GetPage> routes = [
    // Splash
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Onboarding
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
      transition: Transition.rightToLeftWithFade,
    ),

    // Auth Pages
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignupScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () => const OtpVerificationScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
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
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),

    // Stay / Accommodation (Core Module)
    GetPage(
      name: AppRoutes.stayList,
      page: () => const Staylist(),
      binding: StayBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.stayDetails,
      page: () => const PropertyDetailsScreen(),
      binding: PropertyDetailsBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.fullScreenGallery,
      page: () => const FullScreenGalleryScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.staySearch,
      page: () => const SearchScreen(),
      binding: SearchBinding(),
      transition: Transition.downToUp,
    ),

    // Booking Flow
    GetPage(
      name: AppRoutes.bookingCheckout,
      page: () => const BookingCheckoutScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.bookingConfirmation,
      page: () => const BookingConfirmationScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.bookingDetails,
      page: () => const BookingDetailsScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.booking,
      page: () => const BookingsScreen(),
      binding: BookingsBinding(),
      transition: Transition.rightToLeftWithFade,
    ),

    // Wishlist
    GetPage(
      name: AppRoutes.wishlist,
      page: () => const WishlistScreen(),
      binding: WishlistBinding(),
      transition: Transition.rightToLeftWithFade,
    ),

    // Profile & Settings
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.coupons,
      page: () => const CouponsScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsScreen(),
      transition: Transition.rightToLeftWithFade,
    ),

    // Secondary Marketplace Modules
    GetPage(
      name: AppRoutes.services,
      page: () => const ServicesScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.rentals,
      page: () => const RentalScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.trips,
      page: () => const TripsScreen(),
      binding: TripsBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.shop,
      page: () => const ShopScreen(),
      binding: ShopBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => const PaymentMethodsScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
