import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../models/product_variant_model.dart';

/// Variant picker chips (e.g. Size, Weight: 250g/500g/1kg)
class ProductVariantSelector extends StatelessWidget {
  final List<ProductVariantModel> variants;
  final ProductVariantModel? selectedVariant;
  final ValueChanged<ProductVariantModel> onSelected;

  const ProductVariantSelector({
    super.key,
    required this.variants,
    required this.selectedVariant,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (variants.isEmpty) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final variantType = variants.first.type;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Select $variantType: ',
              style: AppTextStyles.titleSmall(isDark).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            if (selectedVariant != null)
              Text(
                selectedVariant!.value,
                style: AppTextStyles.titleSmall(isDark).copyWith(
                  color: isDark ? AppColors.primaryLight : AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: variants.map((v) {
            final isSelected = selectedVariant?.id == v.id;
            return Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: AppRadius.radiusMd,
                onTap: v.isAvailable ? () => onSelected(v) : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isDark
                            ? AppColors.primaryContainerDark
                            : AppColors.primaryContainer)
                        : (isDark
                            ? AppColors.surfaceVariantDark
                            : AppColors.surfaceLight),
                    borderRadius: AppRadius.radiusMd,
                    border: Border.all(
                      color: isSelected
                          ? (isDark
                              ? AppColors.primaryLight
                              : AppColors.primary)
                          : (isDark
                              ? AppColors.borderDark
                              : AppColors.borderLight),
                      width: isSelected ? 1.5 : 1.0,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        v.name,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: isSelected
                              ? FontWeight.w800
                              : FontWeight.w600,
                          color: isSelected
                              ? (isDark
                                  ? AppColors.primaryLight
                                  : AppColors.primary)
                              : (isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight),
                        ),
                      ),
                      if (v.priceDelta > 0)
                        Text(
                          '+₹${v.priceDelta.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.textMutedDark
                                : AppColors.textMutedLight,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
