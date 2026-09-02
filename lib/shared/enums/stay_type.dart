/// Primary Stay Types supported in the marketplace
enum StayType {
  room('Room', 'Single / double private rooms', '🚪'),
  pg('PG / Hostel', 'Paying Guest with food & laundry', '🏢'),
  mess('Mess / Food', 'Daily subscription meals & dining', '🍲'),
  homestay('Homestay', 'Authentic local stays & villas', '🏡'),
  hotel('Hotel & Resort', 'Luxury & budget hotel rooms', '🏨');

  final String label;
  final String description;
  final String emoji;

  const StayType(this.label, this.description, this.emoji);
}
