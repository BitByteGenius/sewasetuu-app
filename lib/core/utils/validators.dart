/// Form validation helpers
abstract class AppValidators {
  static String? validateRequired(String? value, [String message = 'This field is required']) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? required(String? value, {String? fieldName}) {
    return validateRequired(value, fieldName != null ? '$fieldName is required' : 'This field is required');
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? email(String? value) => validateEmail(value);

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegExp = RegExp(r'^[0-9]{10}$');
    if (!phoneRegExp.hasMatch(value.replaceAll(RegExp(r'\s+|-'), ''))) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  static String? phone(String? value) => validatePhone(value);

  static String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? password(String? value) => validatePassword(value);
}
