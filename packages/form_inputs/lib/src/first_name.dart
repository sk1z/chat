import 'package:formz/formz.dart';

enum FirstNameValidationError { empty, invalid }

class FirstName extends FormzInput<String, FirstNameValidationError> {
  const FirstName.pure([String value = '']) : super.pure(value);
  const FirstName.dirty([String value = '']) : super.dirty(value);

  // static final _firstNameRegexp = RegExp(r"^[\p{L}'-]*$", unicode: true);

  @override
  FirstNameValidationError? validator(String value) {
    if (value.isEmpty) {
      return FirstNameValidationError.empty;
    }
    // if (!_firstNameRegexp.hasMatch(value)) {
    //   return FirstNameValidationError.invalid;
    // }
    return null;
  }
}
