import 'package:intl/intl.dart';

/// Formatting utility for currency, dates, ratings, and strings.
abstract class AppFormatters {
  static final NumberFormat _currencyFormatter = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );

  static String formatCurrency(num amount) {
    return _currencyFormatter.format(amount);
  }

  static String formatDate(DateTime date, [String pattern = 'dd MMM, yyyy']) {
    return DateFormat(pattern).format(date);
  }

  static String formatDateRange(DateTime start, DateTime end) {
    if (start.month == end.month && start.year == end.year) {
      return '${DateFormat('dd').format(start)} - ${DateFormat('dd MMM, yyyy').format(end)}';
    }
    return '${DateFormat('dd MMM').format(start)} - ${DateFormat('dd MMM, yyyy').format(end)}';
  }

  static String formatRating(double rating) {
    return rating.toStringAsFixed(1);
  }

  static String formatReviewsCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}
