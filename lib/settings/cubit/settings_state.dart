part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.passwordRemoveStatus = FormzSubmissionStatus.initial,
    this.googleUpdateStatus = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  final FormzSubmissionStatus passwordRemoveStatus;
  final FormzSubmissionStatus googleUpdateStatus;
  final String? errorMessage;

  @override
  List<Object> get props => [passwordRemoveStatus, googleUpdateStatus];

  SettingsState copyWith({
    FormzSubmissionStatus? passwordRemoveStatus,
    FormzSubmissionStatus? googleUpdateStatus,
    String? errorMessage,
  }) {
    return SettingsState(
      passwordRemoveStatus: passwordRemoveStatus ?? this.passwordRemoveStatus,
      googleUpdateStatus: googleUpdateStatus ?? this.googleUpdateStatus,
      errorMessage: errorMessage,
    );
  }
}
