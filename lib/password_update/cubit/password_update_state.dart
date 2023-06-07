part of 'password_update_cubit.dart';

class PasswordUpdateState extends Equatable {
  const PasswordUpdateState({
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
    this.passwordReauthenticationRequired = false,
  });

  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;
  final bool passwordReauthenticationRequired;

  @override
  List<Object> get props =>
      [password, status, isValid, passwordReauthenticationRequired];

  PasswordUpdateState copyWith({
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
    bool? passwordReauthenticationRequired,
  }) {
    return PasswordUpdateState(
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage,
      passwordReauthenticationRequired: passwordReauthenticationRequired ??
          this.passwordReauthenticationRequired,
    );
  }
}
