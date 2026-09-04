import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_network_image.dart';
import '../controllers/cart_controller.dart';
import '../models/product_model.dart';
import '../shop_navigator.dart';
import 'product_price_widget.dart';
import 'product_rating_widget.dart';

/// Product card displayed inside product grids and horizontal carousels
class ProductCard extends StatelessWidget {
  final ProductModel product;
  final double? width;
  final double imageHeight;

  const ProductCard({
    super.key,
    required this.product,
    this.width,
    this.imageHeight = 140,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      width: width,
      padding: EdgeInsets.zero,
      onTap: () => ShopNavigator.toProductDetails(product),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image header
          Stack(
            children: [
              AppNetworkImage(
                imageUrl: product.images.isNotEmpty
                    ? product.images.first
                    : 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=600&q=80',
                height: imageHeight,
                width: double.infinity,
                borderRadius: AppRadius.topXl,
              ),
              // State origin badge
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(180),
                    borderRadius: AppRadius.radiusPill,
                    border: Border.all(color: Colors.white.withAlpha(40)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.place_rounded,
                        color: AppColors.secondary,
                        size: 11,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        product.stateName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Quick Add to Cart button
              Positioned(
                bottom: 8,
                right: 8,
                child: Obx(() {
                  final isAdded = Get.isRegistered<CartController>() &&
                      Get.find<CartController>().isProductInCart(product.id);

                  return Material(
                    color: isAdded
                        ? AppColors.success
                        : (isDark
                            ? AppColors.surfaceDark
                            : AppColors.surfaceLight),
                    shape: const CircleBorder(),
                    elevation: 3,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        if (!Get.isRegistered<CartController>()) {
                          Get.put(CartController());
                        }
                        Get.find<CartController>().addToCart(product);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Icon(
                          isAdded
                              ? Icons.check_rounded
                              : Icons.add_shopping_cart_rounded,
                          size: 16,
                          color: isAdded
                              ? Colors.white
                              : (isDark
                                  ? AppColors.primaryLight
                                  : AppColors.primary),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          // Product Info
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category & Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.categoryName.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelSmall(isDark).copyWith(
                          fontSize: 9.5,
                          color: isDark
                              ? AppColors.textMutedDark
                              : AppColors.textMutedLight,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    ProductRatingWidget(
                      rating: product.rating,
                      showCount: false,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Title
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleSmall(isDark).copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                    fontSize: 13,
                  ),
                ),
                AppSpacing.gapV8,
                // Price
                ProductPriceWidget(
                  price: product.price,
                  originalPrice: product.originalPrice,
                  discountPercentage: product.discountPercentage,
                  fontSize: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
