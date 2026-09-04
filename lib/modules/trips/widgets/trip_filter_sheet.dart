import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../models/destination_model.dart';
import '../models/trip_filter_model.dart';
import '../models/trip_theme_model.dart';

/// Modal bottom sheet for refining travel packages by destination, theme, duration, and budget
class TripFilterSheet extends StatefulWidget {
  final TripFilterModel initialFilter;
  final List<DestinationModel> destinations;
  final List<TripThemeModel> themes;
  final ValueChanged<TripFilterModel> onApply;

  const TripFilterSheet({
    super.key,
    required this.initialFilter,
    required this.destinations,
    required this.themes,
    required this.onApply,
  });

  @override
  State<TripFilterSheet> createState() => _TripFilterSheetState();
}

class _TripFilterSheetState extends State<TripFilterSheet> {
  late String? _selectedDestinationId;
  late String? _selectedThemeId;
  late int? _selectedDurationDays;
  late RangeValues _budgetRange;
  late double? _minRating;
  late TripSortOption _sortOption;

  @override
  void initState() {
    super.initState();
    _selectedDestinationId = widget.initialFilter.destinationId;
    _selectedThemeId = widget.initialFilter.themeId;
    _selectedDurationDays = widget.initialFilter.maxDurationDays;
    _budgetRange = RangeValues(
      widget.initialFilter.minBudget ?? 8000,
      widget.initialFilter.maxBudget ?? 35000,
    );
    _minRating = widget.initialFilter.minRating;
    _sortOption = widget.initialFilter.sortOption;
  }

  void _reset() {
    setState(() {
      _selectedDestinationId = null;
      _selectedThemeId = null;
      _selectedDurationDays = null;
      _budgetRange = const RangeValues(8000, 35000);
      _minRating = null;
      _sortOption = TripSortOption.popularity;
    });
  }

  void _apply() {
    int? minDur;
    int? maxDur;
    if (_selectedDurationDays != null) {
      if (_selectedDurationDays == 4) {
        minDur = 1;
        maxDur = 4;
      } else if (_selectedDurationDays == 6) {
        minDur = 5;
        maxDur = 6;
      } else if (_selectedDurationDays == 7) {
        minDur = 7;
        maxDur = 20;
      }
    }

    final newFilter = TripFilterModel(
      destinationId: _selectedDestinationId,
      themeId: _selectedThemeId,
      minDurationDays: minDur,
      maxDurationDays: maxDur,
      minBudget: _budgetRange.start,
      maxBudget: _budgetRange.end,
      minRating: _minRating,
      sortOption: _sortOption,
    );

    widget.onApply(newFilter);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Header Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filters & Preferences',
                  style: AppTextStyles.titleMedium(isDark).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: _reset,
                      child: Text(
                        'Reset All',
                        style: TextStyle(
                          color: isDark
                              ? AppColors.primaryLight
                              : AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Scrollable Filter Sections
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Destination
                  _buildSectionTitle('Destination', isDark),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.destinations.map((dest) {
                      final isSelected = _selectedDestinationId == dest.id;
                      return ChoiceChip(
                        label: Text(dest.name),
                        selected: isSelected,
                        selectedColor: isDark
                            ? AppColors.primaryLight
                            : AppColors.primary,
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                          color: isSelected
                              ? (isDark ? Colors.black : Colors.white)
                              : (isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight),
                        ),
                        onSelected: (val) {
                          setState(() {
                            _selectedDestinationId = val ? dest.id : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  AppSpacing.gapV24,

                  // 2. Travel Theme
                  _buildSectionTitle('Travel Style / Theme', isDark),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.themes.map((theme) {
                      final isSelected = _selectedThemeId == theme.id;
                      return ChoiceChip(
                        label: Text('${theme.emoji} ${theme.name}'),
                        selected: isSelected,
                        selectedColor: isDark
                            ? AppColors.primaryLight
                            : AppColors.primary,
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                          color: isSelected
                              ? (isDark ? Colors.black : Colors.white)
                              : (isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight),
                        ),
                        onSelected: (val) {
                          setState(() {
                            _selectedThemeId = val ? theme.id : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  AppSpacing.gapV24,

                  // 3. Duration
                  _buildSectionTitle('Trip Duration', isDark),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildDurationChip(4, 'Short (1-4 Days)', isDark),
                      const SizedBox(width: 8),
                      _buildDurationChip(6, 'Medium (5-6 Days)', isDark),
                      const SizedBox(width: 8),
                      _buildDurationChip(7, 'Long (7+ Days)', isDark),
                    ],
                  ),
                  AppSpacing.gapV24,

                  // 4. Budget Range Slider
                  _buildSectionTitle(
                    'Budget per Person (₹${_budgetRange.start.toInt()} - ₹${_budgetRange.end.toInt()})',
                    isDark,
                  ),
                  RangeSlider(
                    values: _budgetRange,
                    min: 5000,
                    max: 40000,
                    divisions: 35,
                    activeColor:
                        isDark ? AppColors.primaryLight : AppColors.primary,
                    labels: RangeLabels(
                      '₹${_budgetRange.start.toInt()}',
                      '₹${_budgetRange.end.toInt()}',
                    ),
                    onChanged: (values) {
                      setState(() {
                        _budgetRange = values;
                      });
                    },
                  ),
                  AppSpacing.gapV20,

                  // 5. Minimum Rating
                  _buildSectionTitle('Minimum Rating', isDark),
                  const SizedBox(height: 10),
                  Row(
                    children: [4.5, 4.7, 4.9].map((rating) {
                      final isSelected = _minRating == rating;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: FilterChip(
                          avatar: const Icon(Icons.star_rounded,
                              size: 16, color: AppColors.secondary),
                          label: Text('$rating+ Rated'),
                          selected: isSelected,
                          selectedColor: isDark
                              ? AppColors.primaryLight
                              : AppColors.primary,
                          labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                            color: isSelected
                                ? (isDark ? Colors.black : Colors.white)
                                : (isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight),
                          ),
                          onSelected: (val) {
                            setState(() {
                              _minRating = val ? rating : null;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Bottom Action Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              border: Border(
                top: BorderSide(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
            ),
            child: SafeArea(
              child: AppButton.primary(
                text: 'Apply Filters',
                width: double.infinity,
                onPressed: _apply,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: AppTextStyles.titleSmall(isDark).copyWith(
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _buildDurationChip(int value, String label, bool isDark) {
    final isSelected = _selectedDurationDays == value;

    return Expanded(
      child: ChoiceChip(
        label: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
            color: isSelected
                ? (isDark ? Colors.black : Colors.white)
                : (isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight),
          ),
        ),
        selected: isSelected,
        selectedColor: isDark ? AppColors.primaryLight : AppColors.primary,
        onSelected: (val) {
          setState(() {
            _selectedDurationDays = val ? value : null;
          });
        },
      ),
    );
  }
}
