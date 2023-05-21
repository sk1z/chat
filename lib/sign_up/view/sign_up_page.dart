import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/sign_up/sign_up.dart';

import 'package:chat/styles/styles.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpPageStyle style =
        Theme.of(context).extension<SignUpPageStyle>()!;

    return Scaffold(
      backgroundColor: style.backgroundColor,
      appBar: AppBar(title: const Text('Sign Up')),
      body: BlocProvider(
        create: (_) => SignUpCubit(
            authenticationRepository: context.read<AuthenticationRepository>()),
        child: BlocListener<SignUpCubit, SignUpState>(
          listener: (BuildContext context, SignUpState state) {
            if (state.status.isSubmissionFailure) {
              Fluttertoast.cancel();
              Fluttertoast.showToast(
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                msg: state.errorMessage ?? 'Sign Up Failure',
              );
            }
          },
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
