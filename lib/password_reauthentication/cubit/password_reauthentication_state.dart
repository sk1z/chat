part of 'password_reauthentication_cubit.dart';

class PasswordReauthenticationState extends Equatable {
  const PasswordReauthenticationState({
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  final Password password;
  final FormzStatus status;

  @override
  List<Object> get props => [password, status];

  PasswordReauthenticationState copyWith({
    Password? password,
    FormzStatus? status,
  }) {
    return PasswordReauthenticationState(
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
