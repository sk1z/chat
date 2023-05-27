import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'password_reauthentication_state.dart';

class PasswordReauthenticationCubit
    extends Cubit<PasswordReauthenticationState> {
  PasswordReauthenticationCubit(
      {required void Function(String password)? onPasswordConfirmed})
      : _onPasswordConfirmed = onPasswordConfirmed,
        super(const PasswordReauthenticationState());

  final void Function(String password)? _onPasswordConfirmed;

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password]),
    ));
  }

  void passwordConfirmed() {
    if (!state.status.isValidated) return;
    _onPasswordConfirmed?.call(state.password.value);
  }
}
