part of 'name_edit_cubit.dart';

class NameEditState extends Equatable {
  const NameEditState({
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.status = FormzStatus.pure,
  });

  final FirstName firstName;
  final LastName lastName;
  final FormzStatus status;

  @override
  List<Object> get props => [firstName, lastName, status];

  NameEditState copyWith({
    FirstName? firstName,
    LastName? lastName,
    FormzStatus? status,
  }) {
    return NameEditState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      status: status ?? this.status,
    );
  }
}
