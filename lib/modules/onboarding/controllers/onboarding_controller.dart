import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/core/constants/app_constants.dart';
import 'package:sewasetu/core/storage/storage_service.dart';
import '../models/onboarding_slide_model.dart';

class OnboardingController extends GetxController {
  final IStorageService _storageService;

  OnboardingController(this._storageService);

  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingSlideModel> slides = const [
    OnboardingSlideModel(
      badgeText: '',
      title: 'Find Perfect Stays',
      subtitle: '',
      imageUrl: 'https://images.unsplash.com/photo-1587061949409-02df41d5e562?auto=format&fit=crop&w=1000&q=80',
      cardTitle: 'Pine Ridge Cottage',
      cardSubtitle: 'Shillong',
      cardPrice: '₹2,400/nt',
      cardRating: '4.95',
    ),
    OnboardingSlideModel(
      badgeText: '',
      title: 'Explore Curated Treks',
      subtitle: '',
      imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=1000&q=80',
      cardTitle: 'Root Bridges Trek',
      cardSubtitle: 'Meghalaya',
      cardPrice: '₹3,200',
      cardRating: '4.98',
    ),
    OnboardingSlideModel(
      badgeText: '',
      title: 'Rent 4x4s & Shop Local',
      subtitle: '',
      imageUrl: 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&w=1000&q=80',
      cardTitle: 'Thar 4x4 SUV',
      cardSubtitle: 'Guwahati',
      cardPrice: '₹3,800/d',
      cardRating: '4.92',
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

  bool _isCompleting = false;

  Future<void> completeOnboarding() async {
    if (_isCompleting) return;
    _isCompleting = true;

    try {
      await _storageService.setBool(AppConstants.hasSeenOnboardingKey, true);
      await _storageService.setBool(AppConstants.isFirstTimeKey, false);
    } catch (e) {
      debugPrint('Error saving onboarding state: $e');
    }

    Get.offAllNamed(AppRoutes.login);
  }
}
