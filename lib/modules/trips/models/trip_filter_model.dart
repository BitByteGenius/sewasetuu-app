/// Sort options for trip packages
enum TripSortOption {
  popularity('Popularity'),
  priceLowToHigh('Price: Low to High'),
  priceHighToLow('Price: High to Low'),
  highestRated('Highest Rated'),
  durationShort('Duration: Short to Long'),
  durationLong('Duration: Long to Short');

  final String label;
  const TripSortOption(this.label);
}

/// Filter criteria for querying travel packages
class TripFilterModel {
  final String? destinationId;
  final String? themeId;
  final int? minDurationDays;
  final int? maxDurationDays;
  final double? minBudget;
  final double? maxBudget;
  final double? minRating;
  final TripSortOption sortOption;

  const TripFilterModel({
    this.destinationId,
    this.themeId,
    this.minDurationDays,
    this.maxDurationDays,
    this.minBudget,
    this.maxBudget,
    this.minRating,
    this.sortOption = TripSortOption.popularity,
  });

  bool get hasActiveFilters =>
      destinationId != null ||
      themeId != null ||
      minDurationDays != null ||
      maxDurationDays != null ||
      minBudget != null ||
      maxBudget != null ||
      minRating != null ||
      sortOption != TripSortOption.popularity;

  int get activeFilterCount {
    int count = 0;
    if (destinationId != null) count++;
    if (themeId != null) count++;
    if (minDurationDays != null || maxDurationDays != null) count++;
    if (minBudget != null || maxBudget != null) count++;
    if (minRating != null) count++;
    if (sortOption != TripSortOption.popularity) count++;
    return count;
  }

  TripFilterModel reset() {
    return const TripFilterModel();
  }

  TripFilterModel copyWith({
    String? destinationId,
    bool clearDestination = false,
    String? themeId,
    bool clearTheme = false,
    int? minDurationDays,
    int? maxDurationDays,
    double? minBudget,
    double? maxBudget,
    double? minRating,
    TripSortOption? sortOption,
  }) {
    return TripFilterModel(
      destinationId:
          clearDestination ? null : (destinationId ?? this.destinationId),
      themeId: clearTheme ? null : (themeId ?? this.themeId),
      minDurationDays: minDurationDays ?? this.minDurationDays,
      maxDurationDays: maxDurationDays ?? this.maxDurationDays,
      minBudget: minBudget ?? this.minBudget,
      maxBudget: maxBudget ?? this.maxBudget,
      minRating: minRating ?? this.minRating,
      sortOption: sortOption ?? this.sortOption,
    );
  }
}
