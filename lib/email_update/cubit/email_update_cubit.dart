import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'email_update_state.dart';

class EmailUpdateCubit extends Cubit<EmailUpdateState> {
  EmailUpdateCubit({required AuthenticationRepository authenticationRepository})
      : _authRepository = authenticationRepository,
        super(const EmailUpdateState());

  final AuthenticationRepository _authRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email]),
    ));
  }

  Future<void> updateEmail() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
      passwordReauthenticationRequired: false,
    ));
    try {
      await _authRepository.updateEmail(email: state.email.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on EmailUpdateFailure catch (e) {
      if (e.recentLoginRequired) {
        if (_authRepository.currentUser.googleProvider == null) {
          emit(state.copyWith(passwordReauthenticationRequired: true));
          return;
        }

        try {
          if (await _authRepository.reauthenticateWithGoogle()) {
            updateEmail();
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
      updateEmail();
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
