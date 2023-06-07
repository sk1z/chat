part of 'name_edit_cubit.dart';

class NameEditState extends Equatable {
  const NameEditState({
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
  });

  final FirstName firstName;
  final LastName lastName;
  final FormzSubmissionStatus status;
  final bool isValid;

  @override
  List<Object> get props => [firstName, lastName, status, isValid];

  NameEditState copyWith({
    FirstName? firstName,
    LastName? lastName,
    FormzSubmissionStatus? status,
    bool? isValid,
  }) {
    return NameEditState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }
}
