part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.passwordRemoveStatus = FormzStatus.pure,
    this.googleUpdateStatus = FormzStatus.pure,
    this.errorMessage,
  });

  final FormzStatus passwordRemoveStatus;
  final FormzStatus googleUpdateStatus;
  final String? errorMessage;

  @override
  List<Object> get props => [passwordRemoveStatus, googleUpdateStatus];

  SettingsState copyWith({
    FormzStatus? passwordRemoveStatus,
    FormzStatus? googleUpdateStatus,
    String? errorMessage,
  }) {
    return SettingsState(
      passwordRemoveStatus: passwordRemoveStatus ?? this.passwordRemoveStatus,
      googleUpdateStatus: googleUpdateStatus ?? this.googleUpdateStatus,
      errorMessage: errorMessage,
    );
  }
}
