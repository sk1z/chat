import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/login_data_input/login_data_input.dart';
import 'package:flutter_firebase_login/sign_up/sign_up.dart';
import 'package:flutter_firebase_login/styles/styles.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpFormStyle style =
        Theme.of(context).extension<SignUpFormStyle>()!;

    return Align(
      alignment: style.alignment ?? Alignment.center,
      child: SingleChildScrollView(
        child: Padding(
          padding: style.padding ?? EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _EmailInput(),
              const _PasswordInput(),
              const _ConfirmPasswordInput(),
              const _SignUpButton(),
            ],
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState previous, SignUpState current) =>
          previous.email != current.email,
      builder: (BuildContext context, SignUpState state) {
        return LoginDataInput(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (String email) =>
              context.read<SignUpCubit>().emailChanged(email),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          labelText: 'email',
          errorText: state.email.invalid ? 'invalid email' : null,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState previous, SignUpState current) =>
          previous.password != current.password,
      builder: (BuildContext context, SignUpState state) {
        return LoginDataInput(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (String password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          textInputAction: TextInputAction.next,
          obscureText: true,
          labelText: 'password',
          errorText: state.password.invalid ? 'invalid password' : null,
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  const _ConfirmPasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState previous, SignUpState current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (BuildContext context, SignUpState state) {
        return LoginDataInput(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (String confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          onSubmitted: (_) => context.read<SignUpCubit>().signUpFormSubmitted(),
          obscureText: true,
          labelText: 'confirm password',
          errorText:
              state.confirmedPassword.invalid ? 'passwords do not match' : null,
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    final SignUpButtonStyle style =
        Theme.of(context).extension<SignUpButtonStyle>()!;

    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState previous, SignUpState current) =>
          previous.status != current.status,
      builder: (BuildContext context, SignUpState state) {
        if (state.status.isSubmissionInProgress) {
          return const CircularProgressIndicator();
        }

        return Padding(
          padding: style.padding ?? EdgeInsets.zero,
          child: ElevatedButton(
            key: const Key('signUpForm_continue_raisedButton'),
            onPressed: state.status.isValidated
                ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                : null,
            child: const Text('SIGN UP'),
            style: style.style,
          ),
        );
      },
    );
  }
}
