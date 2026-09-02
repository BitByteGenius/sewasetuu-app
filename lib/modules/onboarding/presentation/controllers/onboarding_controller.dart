import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/storage/storage_service.dart';
import '../widgets/onboarding_slide_widget.dart';

class OnboardingController extends GetxController {
  final IStorageService _storageService;

  OnboardingController(this._storageService);

  final PageController pageController = PageController();
  final RxInt currentPage = 0.0.toInt().obs;

  final List<OnboardingSlide> slides = const [
    OnboardingSlide(
      badgeText: 'CORE STAY PLATFORM',
      title: 'Find Perfect Rooms, PGs & Homestays',
      subtitle: 'Discover verified accommodation with transparent pricing, zero brokerage, hygienic meals, and instant booking.',
      imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80',
    ),
    OnboardingSlide(
      badgeText: 'MULTI-SERVICE MARKETPLACE',
      title: 'Reliable Local Services at Your Doorstep',
      subtitle: 'Easily book trusted electricians, plumbers, home cleaners, and experienced drivers on-demand.',
      imageUrl: 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?auto=format&fit=crop&w=800&q=80',
    ),
    OnboardingSlide(
      badgeText: 'RENTALS & TRAVEL',
      title: 'Rent Vehicles & Explore Dream Destinations',
      subtitle: 'Book self-drive cars, bikes, and curated tour packages for Goa, Manali, Shillong, and beyond.',
      imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80',
    ),
  ];

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < slides.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void completeOnboarding() {
    _storageService.setBool(AppConstants.isFirstTimeKey, false);
    Get.offAllNamed(AppRoutes.main);
  }
}
