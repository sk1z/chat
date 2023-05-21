import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/app/view/app.dart';
import 'package:chat/email_update/email_update.dart';
import 'package:chat/password_reauthentication/password_reauthentication.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';

class EmailUpdateFlow extends StatelessWidget {
  const EmailUpdateFlow();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmailUpdateCubit(
          authenticationRepository: context.read<AuthenticationRepository>()),
      child: BlocConsumer<EmailUpdateCubit, EmailUpdateState>(
        listener: (BuildContext context, EmailUpdateState state) {
          if (state.status.isSubmissionSuccess) {
            Navigator.pop(context);
          } else if (state.status.isSubmissionFailure) {
            Fluttertoast.cancel();
            Fluttertoast.showToast(
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              msg: state.errorMessage ?? 'Email Update Failure',
            );
          }
        },
        buildWhen: (EmailUpdateState previous, EmailUpdateState current) =>
            previous.passwordReauthenticationRequired !=
            current.passwordReauthenticationRequired,
        builder: (BuildContext context, EmailUpdateState state) {
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
  bool passwordReauthenticationRequired,
  List<Page<dynamic>> pages,
) {
  return [
    const MaterialPage<void>(child: EmailUpdatePage()),
    if (passwordReauthenticationRequired)
      SlideWithFadeTransitionPage(
        child: PasswordReauthenticationPage(
          onPasswordConfirmed: (String password) => context
              .read<EmailUpdateCubit>()
              .reauthenticateWithPassword(password),
          helper: 'You need to re-authenticate to update your email.',
        ),
      ),
  ];
}
