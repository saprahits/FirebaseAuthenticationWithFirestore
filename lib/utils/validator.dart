import 'package:demo/utils/validation_string.dart';

class Validator {
  static String? validateName({required String name}) {
    // if (name == null) {
    //   return null;
    // }
    if (name.isEmpty) {
      return ValidationString.errorNameEmpty;
    }
    return null;
  }

  static String? validateEmail({required String email}) {
    // if (email == null) {
    //   return null;
    // }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (email.isEmpty) {
      return ValidationString.errorEmailEmpty;
    } else if (!emailRegExp.hasMatch(email)) {
      return ValidationString.errorInValidEmail;
    }
    return null;
  }

  static String? validatePassword({required String password}) {
    // if (password == null) {
    //   return null;
    // }
    if (password.isEmpty) {
      return ValidationString.errorPasswordEmpty;
    } else if (password.length < 6) {
      return ValidationString.errorInValidPassword;
    }
    return null;
  }
}
