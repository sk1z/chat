part of 'profile_creation_cubit.dart';

class ProfileCreationState extends Equatable {
  const ProfileCreationState({
    this.firstName = const FirstName.pure(),
    this.lastName = '',
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
  });

  final FirstName firstName;
  final String lastName;
  final FormzSubmissionStatus status;
  final bool isValid;

  @override
  List<Object> get props => [firstName, lastName, status, isValid];

  ProfileCreationState copyWith({
    FirstName? firstName,
    String? lastName,
    FormzSubmissionStatus? status,
    bool? isValid,
  }) =>
      ProfileCreationState(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        status: status ?? this.status,
        isValid: isValid ?? this.isValid,
      );
}
