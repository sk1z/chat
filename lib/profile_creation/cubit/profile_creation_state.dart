part of 'profile_creation_cubit.dart';

class ProfileCreationState extends Equatable {
  const ProfileCreationState({
    this.firstName = const FirstName.pure(),
    this.lastName = '',
    this.status = FormzStatus.pure,
  });

  final FirstName firstName;
  final String lastName;
  final FormzStatus status;

  @override
  List<Object> get props => [firstName, lastName, status];

  ProfileCreationState copyWith({
    FirstName? firstName,
    String? lastName,
    FormzStatus? status,
  }) =>
      ProfileCreationState(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        status: status ?? this.status,
      );
}
