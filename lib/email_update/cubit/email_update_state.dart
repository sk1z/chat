part of 'email_update_cubit.dart';

class EmailUpdateState extends Equatable {
  const EmailUpdateState({
    this.email = const Email.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.passwordReauthenticationRequired = false,
  });

  final Email email;
  final FormzStatus status;
  final String? errorMessage;
  final bool passwordReauthenticationRequired;

  @override
  List<Object> get props => [email, status, passwordReauthenticationRequired];

  EmailUpdateState copyWith({
    Email? email,
    FormzStatus? status,
    String? errorMessage,
    bool? passwordReauthenticationRequired,
  }) {
    return EmailUpdateState(
      email: email ?? this.email,
      status: status ?? this.status,
      errorMessage: errorMessage,
      passwordReauthenticationRequired: passwordReauthenticationRequired ??
          this.passwordReauthenticationRequired,
    );
  }
}
