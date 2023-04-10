import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'password_update_state.dart';

class PasswordUpdateCubit extends Cubit<PasswordUpdateState> {
  PasswordUpdateCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authRepository = authenticationRepository,
        super(const PasswordUpdateState());

  final AuthenticationRepository _authRepository;

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password]),
    ));
  }

  Future<void> updatePassword() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
      passwordReauthenticationRequired: false,
    ));
    try {
      await _authRepository.updatePassword(password: state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on PasswordUpdateFailure catch (e) {
      if (e.recentLoginRequired) {
        if (_authRepository.currentUser.googleProvider == null) {
          emit(state.copyWith(passwordReauthenticationRequired: true));
          return;
        }

        try {
          if (await _authRepository.reauthenticateWithGoogle()) {
            updatePassword();
          } else {
            emit(state.copyWith(
              status: FormzStatus.submissionFailure,
              errorMessage: e.message,
            ));
          }
        } on ReauthenticationFailure catch (e) {
          emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: e.message,
          ));
        } catch (_) {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } else {
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: e.message,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> reauthenticateWithPassword(String password) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authRepository.reauthenticateWithPassword(password: password);
      updatePassword();
    } on ReauthenticationFailure catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
