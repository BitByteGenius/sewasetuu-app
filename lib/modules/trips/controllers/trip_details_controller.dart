import 'package:get/get.dart';
import '../models/traveler_model.dart';
import '../models/trip_package_model.dart';

/// Controller powering the comprehensive trip package presentation and booking setup
class TripDetailsController extends GetxController {
  final TripPackageModel package;

  TripDetailsController({required this.package});

  final RxInt currentPhotoIndex = 0.obs;
  final Rxn<DateTime> selectedDate = Rxn<DateTime>();
  final Rx<TravelerModel> travelers = const TravelerModel(adults: 2, children: 0, rooms: 1).obs;

  // Set of day numbers that are expanded in the day-by-day itinerary view
  final RxSet<int> expandedDays = <int>{1}.obs; // Day 1 open by default

  @override
  void onInit() {
    super.onInit();
    if (package.availableDates.isNotEmpty) {
      selectedDate.value = package.availableDates.first;
    } else {
      selectedDate.value = DateTime.now().add(const Duration(days: 10));
    }
  }

  void setPhotoIndex(int index) {
    currentPhotoIndex.value = index;
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  void updateTravelers({int? adults, int? children, int? rooms, String? specialRequests}) {
    travelers.value = travelers.value.copyWith(
      adults: adults,
      children: children,
      rooms: rooms,
      specialRequests: specialRequests,
    );
  }

  void toggleDayExpanded(int dayNumber) {
    if (expandedDays.contains(dayNumber)) {
      expandedDays.remove(dayNumber);
    } else {
      expandedDays.add(dayNumber);
    }
  }

  void expandAllDays() {
    expandedDays.addAll(package.itinerary.map((d) => d.dayNumber));
  }

  void collapseAllDays() {
    expandedDays.clear();
  }

  // --- Dynamic Pricing Calculations ---

  double get adultSubtotal => package.basePrice * travelers.value.adults;

  // Children typically charged at 60% of base rate
  double get childSubtotal =>
      (package.basePrice * 0.6) * travelers.value.children;

  double get subtotal => adultSubtotal + childSubtotal;

  // 5% GST on packaged tours
  double get gstTax => subtotal * 0.05;

  double get grandTotal => subtotal + gstTax;

  // 25% booking advance deposit option
  double get bookingDeposit => grandTotal * 0.25;

  double get pricePerPerson => package.basePrice;
}
