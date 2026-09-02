import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';

class RentalVehicle {
  final String name;
  final String category;
  final String priceText;
  final String imageUrl;
  final String transmission;

  const RentalVehicle({
    required this.name,
    required this.category,
    required this.priceText,
    required this.imageUrl,
    required this.transmission,
  });
}

/// Secondary Module: Car & Bike Rentals marketplace.
class RentalsScreen extends StatelessWidget {
  const RentalsScreen({super.key});

  static const vehicles = [
    RentalVehicle(
      name: 'Hyundai Creta SX',
      category: 'Self-Drive SUV',
      priceText: '₹2,400 / day',
      imageUrl: 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&w=600&q=80',
      transmission: 'Automatic • 5 Seater • Petrol',
    ),
    RentalVehicle(
      name: 'Royal Enfield Classic 350',
      category: 'Touring Motorbike',
      priceText: '₹1,100 / day',
      imageUrl: 'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?auto=format&fit=crop&w=600&q=80',
      transmission: 'Manual • Helmets Included',
    ),
    RentalVehicle(
      name: 'Mahindra Thar 4x4',
      category: 'Off-Road Adventure',
      priceText: '₹3,500 / day',
      imageUrl: 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&w=600&q=80',
      transmission: 'Manual • 4x4 • Diesel',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vehicle Rentals',
          style: AppTextStyles.headlineSmall(isDark),
        ),
      ),
      body: ListView.separated(
        padding: AppSpacing.screenPadding,
        itemCount: vehicles.length,
        separatorBuilder: (context, index) => AppSpacing.gapV16,
        itemBuilder: (context, index) {
          final item = vehicles[index];
          return AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppNetworkImage(
                  imageUrl: item.imageUrl,
                  height: 160,
                  width: double.infinity,
                ),
                Padding(
                  padding: AppSpacing.edgeInsetsLg,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.name,
                            style: AppTextStyles.titleLarge(isDark).copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            item.priceText,
                            style: AppTextStyles.priceTag(isDark, fontSize: 16),
                          ),
                        ],
                      ),
                      AppSpacing.gapV4,
                      Text(
                        '${item.category} • ${item.transmission}',
                        style: AppTextStyles.bodySmall(isDark),
                      ),
                      AppSpacing.gapV16,
                      AppButton.primary(
                        text: 'Rent Vehicle',
                        width: double.infinity,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Selected ${item.name} rental')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

typedef RentalsPage = RentalsScreen;
