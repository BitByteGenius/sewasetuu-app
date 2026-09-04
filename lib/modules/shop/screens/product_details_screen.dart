import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../controllers/cart_controller.dart';
import '../controllers/product_details_controller.dart';
import '../models/product_model.dart';
import '../shop_navigator.dart';
import '../widgets/add_to_cart_button.dart';
import '../widgets/product_image_gallery.dart';
import '../widgets/product_price_widget.dart';
import '../widgets/product_rating_widget.dart';
import '../widgets/product_variant_selector.dart';
import '../widgets/quantity_selector.dart';

/// Comprehensive product details screen displaying gallery, heritage story, variants and reviews
class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final ProductDetailsController controller;

  @override
  void initState() {
    super.initState();
    final tag = widget.product.id;
    if (Get.isRegistered<ProductDetailsController>(tag: tag)) {
      controller = Get.find<ProductDetailsController>(tag: tag);
    } else {
      controller = Get.put(
        ProductDetailsController(product: widget.product),
        tag: tag,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
        title: Text(
          product.stateName,
          style: AppTextStyles.titleMedium(isDark).copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          // Live cart icon
          Obx(() {
            final cartCount = Get.isRegistered<CartController>()
                ? Get.find<CartController>().totalUnits
                : 0;

            return Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined),
                  onPressed: () => ShopNavigator.toCart(),
                ),
                if (cartCount > 0)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '$cartCount',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Hero Gallery
            ProductImageGallery(images: product.images),

            Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // State & Category Tag
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.primaryContainerDark
                              : AppColors.primaryContainer,
                          borderRadius: AppRadius.radiusPill,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.place_rounded,
                              color: AppColors.primary,
                              size: 12,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              product.stateName,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: isDark
                                    ? AppColors.primaryLight
                                    : AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '•  ${product.categoryName}',
                        style: AppTextStyles.bodySmall(isDark).copyWith(
                          color: isDark
                              ? AppColors.textMutedDark
                              : AppColors.textSecondaryLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.gapV12,

                  // Product Title
                  Text(
                    product.name,
                    style: AppTextStyles.headlineSmall(isDark).copyWith(
                      fontWeight: FontWeight.w800,
                      height: 1.25,
                    ),
                  ),
                  AppSpacing.gapV12,

                  // Rating & Reviews row
                  Row(
                    children: [
                      ProductRatingWidget(
                        rating: product.rating,
                        reviewCount: product.reviewCount,
                        iconSize: 16,
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 1,
                        height: 14,
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        product.stock > 0
                            ? 'In Stock (${product.stock} available)'
                            : 'Out of Stock',
                        style: TextStyle(
                          color: product.stock > 0
                              ? AppColors.success
                              : AppColors.error,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.gapV16,

                  // Price
                  Obx(() {
                    return ProductPriceWidget(
                      price: controller.currentEffectivePrice,
                      originalPrice: product.originalPrice,
                      discountPercentage: product.discountPercentage,
                      fontSize: 22,
                    );
                  }),
                  AppSpacing.gapV20,
                  const Divider(),
                  AppSpacing.gapV16,

                  // 2. Variants Selector (if any)
                  if (product.variants.isNotEmpty) ...[
                    Obx(() {
                      return ProductVariantSelector(
                        variants: product.variants,
                        selectedVariant: controller.selectedVariant.value,
                        onSelected: controller.selectVariant,
                      );
                    }),
                    AppSpacing.gapV20,
                  ],

                  // 3. Quantity Stepper
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity:',
                        style: AppTextStyles.titleSmall(isDark).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Obx(() {
                        return QuantitySelector(
                          quantity: controller.quantity.value,
                          onIncrement: controller.incrementQuantity,
                          onDecrement: controller.decrementQuantity,
                        );
                      }),
                    ],
                  ),
                  AppSpacing.gapV24,

                  // 4. Tab Selector: [About, Cultural Heritage, Reviews]
                  Obx(() {
                    return Row(
                      children: [
                        _buildTabButton(
                          isDark,
                          title: 'About Product',
                          index: 0,
                        ),
                        _buildTabButton(
                          isDark,
                          title: 'Cultural Heritage',
                          index: 1,
                        ),
                        _buildTabButton(
                          isDark,
                          title: 'Reviews (${controller.reviews.length})',
                          index: 2,
                        ),
                      ],
                    );
                  }),
                  AppSpacing.gapV16,

                  // 5. Tab Content
                  Obx(() {
                    switch (controller.activeTab.value) {
                      case 1:
                        return _buildHeritageTab(isDark, product);
                      case 2:
                        return _buildReviewsTab(isDark);
                      case 0:
                      default:
                        return _buildAboutTab(isDark, product);
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      // Sticky Add to Cart
      bottomNavigationBar: Obx(() {
        final isInCart = Get.isRegistered<CartController>() &&
            Get.find<CartController>().isProductInCart(product.id);

        return AddToCartButton(
          price: controller.currentEffectivePrice * controller.quantity.value,
          isInCart: isInCart,
          onAddToCart: controller.addToCart,
          onGoToCart: () => ShopNavigator.toCart(),
        );
      }),
    );
  }

  Widget _buildTabButton(bool isDark, {required String title, required int index}) {
    final isSelected = controller.activeTab.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? (isDark ? AppColors.primaryLight : AppColors.primary)
                    : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              color: isSelected
                  ? (isDark ? AppColors.primaryLight : AppColors.primary)
                  : (isDark
                      ? AppColors.textMutedDark
                      : AppColors.textSecondaryLight),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutTab(bool isDark, ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.description,
          style: AppTextStyles.bodyMedium(isDark).copyWith(
            height: 1.45,
          ),
        ),
        AppSpacing.gapV16,
        if (product.material != null)
          _buildInfoRow(isDark, 'Material', product.material!),
        if (product.origin != null)
          _buildInfoRow(isDark, 'Origin', product.origin!),
        if (product.sellerName != null)
          _buildInfoRow(isDark, 'Artisan / Guild', product.sellerName!),
      ],
    );
  }

  Widget _buildHeritageTab(bool isDark, ProductModel product) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      backgroundColor: isDark
          ? AppColors.surfaceVariantDark
          : AppColors.primaryContainer.withAlpha(60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('📜', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                'Cultural Story & Authenticity',
                style: AppTextStyles.titleMedium(isDark).copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          AppSpacing.gapV12,
          Text(
            product.culturalSignificance ??
                'This item represents ancestral craftsmanship preserved across generations in ${product.stateName}.',
            style: AppTextStyles.bodyMedium(isDark).copyWith(
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab(bool isDark) {
    if (controller.reviews.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text('No reviews yet. Be the first to review!'),
        ),
      );
    }

    return Column(
      children: controller.reviews.map((rev) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppCard(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      rev.userName,
                      style: AppTextStyles.titleSmall(isDark).copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      rev.dateText,
                      style: AppTextStyles.bodySmall(isDark).copyWith(
                        fontSize: 11,
                        color: isDark
                            ? AppColors.textMutedDark
                            : AppColors.textMutedLight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                ProductRatingWidget(rating: rev.rating, showCount: false),
                AppSpacing.gapV8,
                Text(
                  rev.comment,
                  style: AppTextStyles.bodySmall(isDark).copyWith(
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInfoRow(bool isDark, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: AppTextStyles.bodySmall(isDark).copyWith(
                fontWeight: FontWeight.w700,
                color: isDark
                    ? AppColors.textMutedDark
                    : AppColors.textSecondaryLight,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodySmall(isDark).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
