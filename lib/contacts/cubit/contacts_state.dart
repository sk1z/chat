part of 'contacts_cubit.dart';

class ContactsState extends Equatable {
  const ContactsState({this.contacts = const []});

  final List<Profile> contacts;

  @override
  List<Object> get props => [contacts];
}
