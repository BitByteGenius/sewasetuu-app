import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sewasetu/core/storage/storage_service.dart';
import 'package:sewasetu/modules/splash/controllers/splash_controller.dart';

/// Premium animated splash screen featuring the centered SewaSetu brand logo.
/// Smoothly displays the logo clipped with [ClipRect], then after a brief hold,
/// smoothly zooms out until it completely covers the screen and navigates to the next route.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeInAnimation;
  late final SplashController _controller;

  static const Color _brandBackgroundColor = Color(0xFFFFF1DA);
  static const String _logoAssetPath = 'assets/images/logo.png';
  static const double _baseLogoSize = 160.0;

  @override
  void initState() {
    super.initState();

    // Resolve or initialize SplashController safely
    _controller = Get.isRegistered<SplashController>()
        ? Get.find<SplashController>()
        : Get.put(SplashController(Get.find<IStorageService>()));

    // 1050ms total duration for a silky, continuous motion with zero stutter
    _animController = AnimationController(
      duration: const Duration(milliseconds: 1050),
      vsync: this,
    );

    // Initial soft fade-in over the first 160ms
    _fadeInAnimation = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.16, curve: Curves.easeOut),
    );

    // Trigger navigation WHILE actively zooming out as it reaches the end (at 0.80)
    // so there is ZERO stop at the end, and the next screen smoothly pops in with continuous momentum!
    _animController.addListener(() {
      if (_animController.value >= 0.80) {
        _controller.navigateToNext();
      }
    });

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.navigateToNext();
      }
    });

    // Begin animation immediately on mount
    _animController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pre-cache asset to prevent GPU texture upload jank on initial frame
    precacheImage(const AssetImage(_logoAssetPath), context);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final maxDimension = math.max(
      screenSize.width > 0 ? screenSize.width : 400.0,
      screenSize.height > 0 ? screenSize.height : 800.0,
    );

    // Balanced zoom scale: covers screen without extreme distortion or blur
    final targetScale = (maxDimension / (_baseLogoSize * 1.1)).clamp(3.8, 5.2);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: _brandBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: _brandBackgroundColor,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _controller.navigateToNext(),
          child: SizedBox.expand(
            child: Center(
              child: RepaintBoundary(
                child: AnimatedBuilder(
                  animation: _animController,
                  builder: (context, child) {
                    final t = _animController.value;

                    // Smooth accelerating zoom-out from t = 0.16 to t = 1.00
                    // Uses Curves.easeInQuad so the motion accelerates directly into the incoming pop transition
                    double scale = 1.0;
                    if (t > 0.16) {
                      final p = ((t - 0.16) / 0.84).clamp(0.0, 1.0);
                      final curved = Curves.easeInQuad.transform(p);
                      scale = 1.0 + (targetScale - 1.0) * curved;
                    }

                    return FadeTransition(
                      opacity: _fadeInAnimation,
                      child: Transform.scale(
                        scale: scale,
                        alignment: Alignment.center,
                        child: child,
                      ),
                    );
                  },
                  child: ClipRect(
                    child: Image.asset(
                      _logoAssetPath,
                      width: _baseLogoSize,
                      height: _baseLogoSize,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

typedef SplashPage = SplashScreen;
