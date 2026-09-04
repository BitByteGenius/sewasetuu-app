/// Model representing one single day of an organized trip package itinerary
class ItineraryDayModel {
  final int dayNumber;
  final String title;
  final String description;
  final List<String> activities;
  final List<String> meals;
  final String? stayLocation;
  final List<String> photos;

  const ItineraryDayModel({
    required this.dayNumber,
    required this.title,
    required this.description,
    this.activities = const [],
    this.meals = const [],
    this.stayLocation,
    this.photos = const [],
  });

  String get dayHeader => 'DAY $dayNumber';

  factory ItineraryDayModel.fromJson(Map<String, dynamic> json) {
    return ItineraryDayModel(
      dayNumber: json['day_number'] as int? ?? 1,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      activities: (json['activities'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      meals: (json['meals'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      stayLocation: json['stay_location'] as String?,
      photos: (json['photos'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() => {
        'day_number': dayNumber,
        'title': title,
        'description': description,
        'activities': activities,
        'meals': meals,
        'stay_location': stayLocation,
        'photos': photos,
      };

  ItineraryDayModel copyWith({
    int? dayNumber,
    String? title,
    String? description,
    List<String>? activities,
    List<String>? meals,
    String? stayLocation,
    List<String>? photos,
  }) {
    return ItineraryDayModel(
      dayNumber: dayNumber ?? this.dayNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      activities: activities ?? this.activities,
      meals: meals ?? this.meals,
      stayLocation: stayLocation ?? this.stayLocation,
      photos: photos ?? this.photos,
    );
  }
}
