import 'package:sewasetu/shared/enums/stay_type.dart';

/// Data Model representing a Stay Category for search and filter configurations
class StayCategoryModel {
  final String id;
  final String label;
  final String code;
  final String emoji;
  final String description;
  final StayType? stayType;

  const StayCategoryModel({
    required this.id,
    required this.label,
    required this.code,
    required this.emoji,
    this.description = '',
    this.stayType,
  });

  factory StayCategoryModel.fromJson(Map<String, dynamic> json) {
    return StayCategoryModel(
      id: json['id'] as String? ?? '',
      label: json['label'] as String? ?? '',
      code: json['code'] as String? ?? '',
      emoji: json['emoji'] as String? ?? '✨',
      description: json['description'] as String? ?? '',
      stayType: json['stay_type'] != null
          ? StayType.values.firstWhere(
              (e) => e.name == json['stay_type'],
              orElse: () => StayType.room,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'code': code,
        'emoji': emoji,
        'description': description,
        'stay_type': stayType?.name,
      };
}

/// Central Model-driven Config registry for Stay Categories
class StayCategoryConfig {
  static const List<StayCategoryModel> defaultCategories = [
    StayCategoryModel(
      id: 'cat-all',
      label: 'All Stays',
      code: 'All',
      emoji: '✨',
      description: 'Explore all available stays',
    ),
    StayCategoryModel(
      id: 'cat-1rk',
      label: '1RK',
      code: '1RK',
      emoji: '🛏️',
      description: 'Compact 1 Room Kitchen flats',
      stayType: StayType.room,
    ),
    StayCategoryModel(
      id: 'cat-1bhk',
      label: '1BHK',
      code: '1BHK',
      emoji: '🏠',
      description: '1 Bedroom Hall Kitchen apartments',
      stayType: StayType.room,
    ),
    StayCategoryModel(
      id: 'cat-2bhk',
      label: '2BHK',
      code: '2BHK',
      emoji: '🏢',
      description: '2 Bedroom Hall Kitchen flats',
      stayType: StayType.room,
    ),
    StayCategoryModel(
      id: 'cat-3bhk',
      label: '3BHK',
      code: '3BHK',
      emoji: '🏰',
      description: 'Spacious 3 BHK apartments',
      stayType: StayType.room,
    ),
    StayCategoryModel(
      id: 'cat-homestay',
      label: 'Homestay',
      code: 'Homestay',
      emoji: '🏡',
      description: 'Local host stays & villas',
      stayType: StayType.homestay,
    ),
    StayCategoryModel(
      id: 'cat-mess',
      label: 'Mess',
      code: 'Mess',
      emoji: 'Mess',
      description: 'Daily dining & food lodging',
      stayType: StayType.mess,
    ),
    StayCategoryModel(
      id: 'cat-hotel',
      label: 'Hotel',
      code: 'Hotel',
      emoji: '🏨',
      description: 'Hotels & resorts',
      stayType: StayType.hotel,
    ),
    StayCategoryModel(
      id: 'cat-room',
      label: 'Room',
      code: 'Room',
      emoji: '🚪',
      description: 'Single / double private rooms',
      stayType: StayType.room,
    ),
    StayCategoryModel(
      id: 'cat-pg',
      label: 'PG / Hostel',
      code: 'PG',
      emoji: '🏬',
      description: 'Paying Guest with food & laundry',
      stayType: StayType.pg,
    ),
  ];
}
