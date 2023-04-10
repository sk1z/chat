import 'package:formz/formz.dart';

enum LastNameValidationError { length, invalid }

class LastName extends FormzInput<String, LastNameValidationError> {
  const LastName.pure([String value = '']) : super.pure(value);
  const LastName.dirty([String value = '']) : super.dirty(value);

  static final _lastNameRegexp = RegExp(r"^[\p{L}'-]*$", unicode: true);

  @override
  LastNameValidationError? validator(String value) {
    if (value.length > 25) {
      return LastNameValidationError.length;
    }
    if (!_lastNameRegexp.hasMatch(value)) {
      return LastNameValidationError.invalid;
    }
    return null;
  }
}
