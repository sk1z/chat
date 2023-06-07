part of 'password_reauthentication_cubit.dart';

class PasswordReauthenticationState extends Equatable {
  const PasswordReauthenticationState({
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
  });

  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;

  @override
  List<Object> get props => [password, status, isValid];

  PasswordReauthenticationState copyWith({
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
  }) {
    return PasswordReauthenticationState(
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }
}
