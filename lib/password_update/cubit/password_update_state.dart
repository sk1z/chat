part of 'password_update_cubit.dart';

class PasswordUpdateState extends Equatable {
  const PasswordUpdateState({
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.passwordReauthenticationRequired = false,
  });

  final Password password;
  final FormzStatus status;
  final String? errorMessage;
  final bool passwordReauthenticationRequired;

  @override
  List<Object> get props =>
      [password, status, passwordReauthenticationRequired];

  PasswordUpdateState copyWith({
    Password? password,
    FormzStatus? status,
    String? errorMessage,
    bool? passwordReauthenticationRequired,
  }) {
    return PasswordUpdateState(
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage,
      passwordReauthenticationRequired: passwordReauthenticationRequired ??
          this.passwordReauthenticationRequired,
    );
  }
}
