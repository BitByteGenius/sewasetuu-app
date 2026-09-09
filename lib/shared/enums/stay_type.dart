/// Primary Stay Types supported in the marketplace
enum StayType {
  room(
    'Room',
    'Single / double private rooms',
    '🚪',
    'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=500&q=80',
  ),
  pg(
    'PG / Hostel',
    'Paying Guest with food & laundry',
    '🏢',
    'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=500&q=80',
  ),
  mess(
    'Mess / Food',
    'Daily subscription meals & dining',
    '🍲',
    'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=500&q=80',
  ),
  homestay(
    'Homestay',
    'Authentic local stays & villas',
    '🏡',
    'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=500&q=80',
  ),
  hotel(
    'Hotel & Resort',
    'Luxury & budget hotel rooms',
    '🏨',
    'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=500&q=80',
  );

  final String label;
  final String description;
  final String emoji;
  final String imageUrl;

  const StayType(this.label, this.description, this.emoji, this.imageUrl);
}
