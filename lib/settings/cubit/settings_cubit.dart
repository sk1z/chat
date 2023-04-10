import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required AuthenticationRepository authenticationRepository})
      : _authRepository = authenticationRepository,
        super(const SettingsState());

  final AuthenticationRepository _authRepository;

  Future<void> removePassword() async {
    if (state.passwordRemoveStatus.isSubmissionInProgress ||
        state.googleUpdateStatus.isSubmissionInProgress) return;
    emit(state.copyWith(
      passwordRemoveStatus: FormzStatus.submissionInProgress,
      googleUpdateStatus: FormzStatus.pure,
    ));
    try {
      if (_authRepository.currentUser.passwordProvider != null) {
        await _authRepository.removePassword();
      }
      emit(state.copyWith(passwordRemoveStatus: FormzStatus.submissionSuccess));
    } on UnlinkFailure catch (e) {
      emit(state.copyWith(
        passwordRemoveStatus: FormzStatus.submissionFailure,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(passwordRemoveStatus: FormzStatus.submissionFailure));
    }
  }

  Future<void> updateGoogle() async {
    if (state.passwordRemoveStatus.isSubmissionInProgress ||
        state.googleUpdateStatus.isSubmissionInProgress) return;
    emit(state.copyWith(
      googleUpdateStatus: FormzStatus.submissionInProgress,
      passwordRemoveStatus: FormzStatus.pure,
    ));
    try {
      if (_authRepository.currentUser.googleProvider == null) {
        await _authRepository.linkGoogle();
      } else {
        await _authRepository.unlinkGoogle();
      }
      emit(state.copyWith(googleUpdateStatus: FormzStatus.submissionSuccess));
    } on LinkWithCredentialFailure catch (e) {
      emit(state.copyWith(
        googleUpdateStatus: FormzStatus.submissionFailure,
        errorMessage: e.message,
      ));
    } on UnlinkFailure catch (e) {
      emit(state.copyWith(
        googleUpdateStatus: FormzStatus.submissionFailure,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(googleUpdateStatus: FormzStatus.submissionFailure));
    }
  }
}
