import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NumberValidator {
  static String? validate(
      String? value, String field, AppLocalizations localizations) {
    if (value == null || value.isEmpty) {
      return "$field ${localizations.validator_not_empty}";
    }

    // Try to parse the value as a number
    final num? number = num.tryParse(value);

    if (number == null) {
      return localizations.validator_number_valid;
    }

    if (number <= 0) {
      return "${field} ${localizations.validator_above_0}";
    }

    return null;
  }
}
