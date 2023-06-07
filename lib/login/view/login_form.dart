import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/login/login.dart';
import 'package:chat/login_data_input/login_data_input.dart';
import 'package:chat/styles/styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginFormStyle style = Theme.of(context).extension<LoginFormStyle>()!;

    return Align(
      alignment: style.alignment ?? Alignment.center,
      child: SingleChildScrollView(
        child: Padding(
          padding: style.padding ?? EdgeInsets.zero,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: style.logoPadding ?? EdgeInsets.zero,
                  child: Image.asset(
                    'assets/bloc_logo_small.png',
                    height: style.logoHeight,
                  ),
                ),
                const _EmailInput(),
                const _PasswordInput(),
                const _LoginButton(),
                const _GoogleLoginButton(),
                const _SignUpTextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (LoginState previous, LoginState current) =>
          previous.email != current.email,
      builder: (BuildContext context, LoginState state) {
        return LoginDataInput(
          onChanged: (String email) =>
              context.read<LoginCubit>().emailChanged(email),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          labelText: 'email',
          errorText: state.email.displayError != null ? 'invalid email' : null,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (LoginState previous, LoginState current) =>
          previous.password != current.password,
      builder: (BuildContext context, LoginState state) {
        return LoginDataInput(
          onChanged: (String password) =>
              context.read<LoginCubit>().passwordChanged(password),
          onSubmitted: (_) => context.read<LoginCubit>().logInWithCredentials(),
          obscureText: true,
          labelText: 'password',
          errorText:
              state.password.displayError != null ? 'invalid password' : null,
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    final LoginButtonStyle style =
        Theme.of(context).extension<LoginButtonStyle>()!;

    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (LoginState previous, LoginState current) =>
          previous.status != current.status,
      builder: (BuildContext context, LoginState state) {
        if (state.status.isInProgress) {
          return const CircularProgressIndicator();
        }

        return Padding(
          padding: style.padding ?? EdgeInsets.zero,
          child: ElevatedButton(
            onPressed: state.isValid
                ? () => context.read<LoginCubit>().logInWithCredentials()
                : null,
            style: style.style,
            child: const Text('LOGIN'),
          ),
        );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  const _GoogleLoginButton();

  @override
  Widget build(BuildContext context) {
    final GoogleLoginButtonStyle style =
        Theme.of(context).extension<GoogleLoginButtonStyle>()!;

    return Padding(
      padding: style.padding ?? EdgeInsets.zero,
      child: ElevatedButton.icon(
        onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
        icon: IconTheme(
          data: style.iconTheme ?? const IconThemeData(),
          child: const Icon(FontAwesomeIcons.google),
        ),
        label: Text('SIGN IN WITH GOOGLE', style: style.labelStyle),
        style: style.style,
      ),
    );
  }
}

class _SignUpTextButton extends StatelessWidget {
  const _SignUpTextButton();

  @override
  Widget build(BuildContext context) {
    final SignUpTextButtonStyle style =
        Theme.of(context).extension<SignUpTextButtonStyle>()!;

    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => context.push('/sign_up'),
      child: Text('CREATE ACCOUNT', style: style.textStyle),
    );
  }
}
