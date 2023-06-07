import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'name_edit_state.dart';

class NameEditCubit extends Cubit<NameEditState> {
  NameEditCubit({required FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        super(NameEditState(
          firstName:
              FirstName.pure(firestoreRepository.currentProfile.firstName),
          lastName: LastName.pure(firestoreRepository.currentProfile.lastName),
        ));

  final FirestoreRepository _firestoreRepository;

  void firstNameChanged(String value) {
    final firstName = FirstName.dirty(value);
    emit(state.copyWith(
      firstName: firstName,
      isValid: Formz.validate([firstName, state.lastName]),
    ));
  }

  void lastNameChanged(String value) {
    final lastName = LastName.dirty(value);
    emit(state.copyWith(
      lastName: lastName,
      isValid: Formz.validate([state.firstName, lastName]),
    ));
  }

  Future<void> editName() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _firestoreRepository.editName(
        firstName: state.firstName.value,
        lastName: state.lastName.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
