/// Model capturing traveler headcount and room configuration for trip bookings
class TravelerModel {
  final int adults;
  final int children;
  final int rooms;
  final String? specialRequests;

  const TravelerModel({
    this.adults = 2,
    this.children = 0,
    this.rooms = 1,
    this.specialRequests,
  });

  int get totalTravelers => adults + children;

  String get travelerSummary {
    final adultPart = '$adults ${adults == 1 ? 'Adult' : 'Adults'}';
    final childPart =
        children > 0 ? ', $children ${children == 1 ? 'Child' : 'Children'}' : '';
    final roomPart = ' • $rooms ${rooms == 1 ? 'Room' : 'Rooms'}';
    return '$adultPart$childPart$roomPart';
  }

  factory TravelerModel.fromJson(Map<String, dynamic> json) {
    return TravelerModel(
      adults: json['adults'] as int? ?? 2,
      children: json['children'] as int? ?? 0,
      rooms: json['rooms'] as int? ?? 1,
      specialRequests: json['special_requests'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'adults': adults,
        'children': children,
        'rooms': rooms,
        'special_requests': specialRequests,
      };

  TravelerModel copyWith({
    int? adults,
    int? children,
    int? rooms,
    String? specialRequests,
  }) {
    return TravelerModel(
      adults: adults ?? this.adults,
      children: children ?? this.children,
      rooms: rooms ?? this.rooms,
      specialRequests: specialRequests ?? this.specialRequests,
    );
  }
}
