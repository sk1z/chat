import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/app/app.dart';
import 'package:chat/password_reauthentication/password_reauthentication.dart';
import 'package:chat/password_update/password_update.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';

class PasswordUpdateFlow extends StatelessWidget {
  const PasswordUpdateFlow();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordUpdateCubit(
          authenticationRepository: context.read<AuthenticationRepository>()),
      child: BlocConsumer<PasswordUpdateCubit, PasswordUpdateState>(
        listener: (BuildContext context, PasswordUpdateState state) {
          if (state.status.isSubmissionSuccess) {
            Navigator.pop(context);
          } else if (state.status.isSubmissionFailure) {
            Fluttertoast.cancel();
            Fluttertoast.showToast(
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              msg: state.errorMessage ?? 'Password Update Failure',
            );
          }
        },
        buildWhen:
            (PasswordUpdateState previous, PasswordUpdateState current) =>
                previous.passwordReauthenticationRequired !=
                current.passwordReauthenticationRequired,
        builder: (BuildContext context, PasswordUpdateState state) {
          return FlowBuilder(
            state: state.passwordReauthenticationRequired,
            onGeneratePages: (
              bool passwordReauthenticationRequired,
              List<Page<dynamic>> pages,
            ) =>
                _onGeneratePages(
                    context, passwordReauthenticationRequired, pages),
          );
        },
      ),
    );
  }
}

List<Page<dynamic>> _onGeneratePages(
  BuildContext context,
  bool passwordREauthenticationRequired,
  List<Page<dynamic>> pages,
) {
  return [
    const MaterialPage<void>(child: PasswordUpdatePage()),
    if (passwordREauthenticationRequired)
      SlideWithFadeTransitionPage(
        child: PasswordReauthenticationPage(
          onPasswordConfirmed: (String password) => context
              .read<PasswordUpdateCubit>()
              .reauthenticateWithPassword(password),
          helper: 'You need to re-authenticate to update your password.',
        ),
      )
  ];
}
