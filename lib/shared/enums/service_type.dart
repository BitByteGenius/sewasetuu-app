/// Secondary Marketplace Service Types (Future Modules)
enum ServiceType {
  electrician('Electrician', 'Wiring, repair & maintenance', '⚡'),
  plumber('Plumber', 'Pipes, leakage & fixtures', '🔧'),
  driver('Home Tuition', 'Learn & Teach', '🚗'),
  cleaning('Deep Cleaning', 'Home, bathroom & sofa sanitization', '🧹'),
  carRental('Car Rental', 'Self-drive & chauffeur cars', '🚘'),
  bikeRental('Bike Rental', 'Scooters & geared motorbikes', '🏍️'),
  tourTrips('Trip Destination', 'Tour packages & travel guides', '🏔️');

  final String label;
  final String description;
  final String emoji;

  const ServiceType(this.label, this.description, this.emoji);
}
