import 'package:formz/formz.dart';

enum FirstNameValidationError { length, invalid }

class FirstName extends FormzInput<String, FirstNameValidationError> {
  const FirstName.pure([String value = '']) : super.pure(value);
  const FirstName.dirty([String value = '']) : super.dirty(value);

  static final _firstNameRegexp = RegExp(r"^[\p{L}'-]*$", unicode: true);

  @override
  FirstNameValidationError? validator(String value) {
    if (value.length < 2 || value.length > 25) {
      return FirstNameValidationError.length;
    }
    if (!_firstNameRegexp.hasMatch(value)) {
      return FirstNameValidationError.invalid;
    }
    return null;
  }
}
