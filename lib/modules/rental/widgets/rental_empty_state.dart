import 'package:flutter/material.dart';
import '../../../shared/widgets/app_empty_state.dart';

/// Clean, informative empty state widget tailored for vehicle rentals.
class RentalEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionText;
  final VoidCallback? onAction;

  const RentalEmptyState({
    super.key,
    this.icon = Icons.directions_car_outlined,
    required this.title,
    required this.message,
    this.actionText,
    this.onAction,
  });

  factory RentalEmptyState.noVehicles({
    VoidCallback? onResetFilters,
  }) {
    return RentalEmptyState(
      icon: Icons.no_crash_outlined,
      title: 'No Vehicles Found',
      message:
          'No vehicles match your selected dates, vehicle category, or filter criteria. Try adjusting your parameters.',
      actionText: onResetFilters != null ? 'Reset Filters' : null,
      onAction: onResetFilters,
    );
  }

  factory RentalEmptyState.comingSoonCity({
    required String cityName,
    VoidCallback? onSwitchCity,
  }) {
    return RentalEmptyState(
      icon: Icons.location_city_outlined,
      title: 'Launching Soon in $cityName',
      message:
          'We are actively preparing curated bikes, SUVs, and cars for $cityName in Phase 2. Please choose an available city for now.',
      actionText: onSwitchCity != null ? 'Select Another City' : null,
      onAction: onSwitchCity,
    );
  }

  factory RentalEmptyState.noBookings({
    VoidCallback? onExplore,
  }) {
    return RentalEmptyState(
      icon: Icons.car_rental_outlined,
      title: 'No Rental Bookings Yet',
      message:
          'You haven\'t reserved any vehicles yet. Find the perfect ride for your next road trip or weekend getaway.',
      actionText: onExplore != null ? 'Explore Vehicles' : null,
      onAction: onExplore,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      icon: icon,
      title: title,
      description: message,
      actionText: actionText,
      onAction: onAction,
    );
  }
}
