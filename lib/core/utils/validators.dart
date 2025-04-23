final emailPattern = RegExp(
  r'^[_a-zA-Z0-9-]+((\.[_a-zA-Z0-9-]+)*|(\+[_a-zA-Z0-9-]+)*)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,4})$',
);

class FormValidator {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!emailPattern.hasMatch(value)) {
      return 'Email is invalid';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }
    if (value.length != 10) {
      return 'Invalid phone number';
    }
    return null;
  }

  static String? empty(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} cannot be empty';
    }
    return null;
  }

  static String? atLeast6Characters(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} cannot be empty';
    }

    if (value.length < 6) {
      return '${fieldName ?? 'Field'} must be at least 6 characters';
    }
    return null;
  }

  static String? samePassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password cannot be empty';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
