import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'profile_creation_state.dart';

class ProfileCreationCubit extends Cubit<ProfileCreationState> {
  ProfileCreationCubit({required FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        super(const ProfileCreationState());

  final FirestoreRepository _firestoreRepository;

  void firstNameChanged(String value) {
    final firstName = FirstName.dirty(value);
    emit(state.copyWith(
      firstName: firstName,
      status: Formz.validate([firstName]),
    ));
  }

  void lastNameChanged(String lastName) {
    emit(state.copyWith(lastName: lastName));
  }

  Future<void> createProfile() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _firestoreRepository.createProfile(
        firstName: state.firstName.value,
        lastName: state.lastName,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
