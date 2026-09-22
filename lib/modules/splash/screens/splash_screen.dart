import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sewasetu/core/storage/storage_service.dart';
import 'package:sewasetu/modules/splash/controllers/splash_controller.dart';

/// Professional, pixel-consistent splash screen for OJIONE.
/// Accurately renders the brand splash artwork with exact light-green gradient background,
/// centered dark blue "oji one" logo, translucent corner accents, and bottom blue wave.
/// Adapts seamlessly across all mobile and tablet screens preserving aspect ratio without distortion.
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

  // Exact brand colors sampled directly from the reference image
  static const Color _brandBackgroundTop = Color(0xFFB4E07D);
  static const Color _brandBackgroundCenter = Color(0xFFCDF297);
  static const Color _brandBackgroundBottom = Color(0xFFB4E07D);

  static const String _primaryAssetPath = 'assets/image/logo.png';
  static const String _fallbackAssetPath = 'assets/images/logo.png';

  @override
  void initState() {
    super.initState();

    // Safely resolve or instantiate SplashController
    _controller = Get.isRegistered<SplashController>()
        ? Get.find<SplashController>()
        : Get.put(SplashController(Get.find<IStorageService>()));

    // Total display duration of 1400ms for a clean, professional startup hold
    _animController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );

    // Subtle soft fade-in over the first 280ms
    _fadeInAnimation = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.20, curve: Curves.easeOut),
    );

    // Trigger smooth transition into the app upon completion
    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.navigateToNext();
      }
    });

    // Start playback
    _animController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage(_primaryAssetPath), context).catchError((_) {
      if (mounted) {
        return precacheImage(const AssetImage(_fallbackAssetPath), context);
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Widget _buildSplashImage() {
    return Image.asset(
      _primaryAssetPath,
      fit: BoxFit.contain,
      alignment: Alignment.center,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          _fallbackAssetPath,
          fit: BoxFit.contain,
          alignment: Alignment.center,
          filterQuality: FilterQuality.high,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: _brandBackgroundTop,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: _brandBackgroundTop,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _controller.navigateToNext(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  _brandBackgroundTop,
                  _brandBackgroundCenter,
                  _brandBackgroundBottom,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = constraints.maxHeight;
                final aspectRatio = width / (height > 0 ? height : 1.0);

                Widget splashContent;

                // Standard modern mobile phone viewports (~0.43 to 0.52 aspect ratio)
                if (aspectRatio <= 0.52) {
                  splashContent = SizedBox.expand(
                    child: ClipRect(
                      child: Image.asset(
                        _primaryAssetPath,
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter,
                        filterQuality: FilterQuality.high,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            _fallbackAssetPath,
                            fit: BoxFit.cover,
                            alignment: Alignment.bottomCenter,
                            filterQuality: FilterQuality.high,
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  // Wider mobile screens (e.g. 16:9), tablets, or landscape viewports
                  // Preserves the full splash artwork completely without any cropping or stretching
                  splashContent = Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 480,
                      ),
                      child: AspectRatio(
                        aspectRatio: 852 / 1846,
                        child: ClipRect(
                          child: _buildSplashImage(),
                        ),
                      ),
                    ),
                  );
                }

                return RepaintBoundary(
                  child: FadeTransition(
                    opacity: _fadeInAnimation,
                    child: splashContent,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

typedef SplashPage = SplashScreen;
