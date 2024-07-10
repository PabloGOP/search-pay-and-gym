import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailValidator {
  static String? validate(String? value, AppLocalizations localizations) {
    if (value == null || value.isEmpty) {
      return "Email ${localizations.validator_not_empty}";
    }

    // Regular expression pattern for validating an email
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return localizations.validator_email_valid;
    }

    return null;
  }
}
