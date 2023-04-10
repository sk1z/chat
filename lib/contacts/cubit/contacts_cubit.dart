import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit({required FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        super(const ContactsState()) {
    _contactsSubscription =
        _firestoreRepository.allProfiles().listen((contacts) {
      emit(ContactsState(contacts: contacts));
    });
  }

  final FirestoreRepository _firestoreRepository;
  late final StreamSubscription<List<Profile>> _contactsSubscription;

  @override
  Future<void> close() {
    _contactsSubscription.cancel();
    return super.close();
  }
}
