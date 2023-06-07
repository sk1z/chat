import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/login/login.dart';
import 'package:chat/styles/styles.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginPageStyle style = Theme.of(context).extension<LoginPageStyle>()!;

    return Scaffold(
      backgroundColor: style.backgroundColor,
      appBar: AppBar(title: const Text('Login')),
      body: BlocProvider(
        create: (_) => LoginCubit(
            authenticationRepository: context.read<AuthenticationRepository>()),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (BuildContext context, LoginState state) {
            if (state.status.isFailure) {
              Fluttertoast.cancel();
              Fluttertoast.showToast(
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                msg: state.errorMessage ?? 'Authentication Failure',
              );
            }
          },
          child: const LoginForm(),
        ),
      ),
    );
  }
}
