/// Booking lifecycle status
enum BookingStatus {
  pending('Pending Confirmation', 'Your booking is awaiting host confirmation'),
  confirmed('Confirmed', 'Booking is approved and active'),
  ongoing('Checked In', 'Currently staying / service in progress'),
  completed('Completed', 'Successfully finished'),
  cancelled('Cancelled', 'Cancelled by user or host');

  final String label;
  final String description;

  const BookingStatus(this.label, this.description);
}
