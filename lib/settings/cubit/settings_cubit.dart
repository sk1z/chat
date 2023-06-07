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
    if (state.passwordRemoveStatus.isInProgress ||
        state.googleUpdateStatus.isInProgress) return;
    emit(state.copyWith(
      passwordRemoveStatus: FormzSubmissionStatus.inProgress,
      googleUpdateStatus: FormzSubmissionStatus.initial,
    ));
    try {
      if (_authRepository.currentUser.passwordProvider != null) {
        await _authRepository.removePassword();
      }
      emit(state.copyWith(passwordRemoveStatus: FormzSubmissionStatus.success));
    } on UnlinkFailure catch (e) {
      emit(state.copyWith(
        passwordRemoveStatus: FormzSubmissionStatus.failure,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(passwordRemoveStatus: FormzSubmissionStatus.failure));
    }
  }

  Future<void> updateGoogle() async {
    if (state.passwordRemoveStatus.isInProgress ||
        state.googleUpdateStatus.isInProgress) return;
    emit(state.copyWith(
      googleUpdateStatus: FormzSubmissionStatus.inProgress,
      passwordRemoveStatus: FormzSubmissionStatus.initial,
    ));
    try {
      if (_authRepository.currentUser.googleProvider == null) {
        await _authRepository.linkGoogle();
      } else {
        await _authRepository.unlinkGoogle();
      }
      emit(state.copyWith(googleUpdateStatus: FormzSubmissionStatus.success));
    } on LinkWithCredentialFailure catch (e) {
      emit(state.copyWith(
        googleUpdateStatus: FormzSubmissionStatus.failure,
        errorMessage: e.message,
      ));
    } on UnlinkFailure catch (e) {
      emit(state.copyWith(
        googleUpdateStatus: FormzSubmissionStatus.failure,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(googleUpdateStatus: FormzSubmissionStatus.failure));
    }
  }
}
