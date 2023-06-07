part of 'email_update_cubit.dart';

class EmailUpdateState extends Equatable {
  const EmailUpdateState({
    this.email = const Email.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
    this.passwordReauthenticationRequired = false,
  });

  final Email email;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;
  final bool passwordReauthenticationRequired;

  @override
  List<Object> get props =>
      [email, status, isValid, passwordReauthenticationRequired];

  EmailUpdateState copyWith({
    Email? email,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
    bool? passwordReauthenticationRequired,
  }) {
    return EmailUpdateState(
      email: email ?? this.email,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage,
      passwordReauthenticationRequired: passwordReauthenticationRequired ??
          this.passwordReauthenticationRequired,
    );
  }
}
