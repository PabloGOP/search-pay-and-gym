import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextValidator {
  static String? validate(
      String? value, String field, AppLocalizations localizations) {
    if (value == null || value.isEmpty) {
      return "$field ${localizations.validator_not_empty}";
    }

    if (value.length < 4) {
      return "$field ${localizations.validator_length}";
    }

    return null;
  }
}
