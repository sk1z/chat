import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/login_data_input/login_data_input.dart';
import 'package:chat/sign_up/sign_up.dart';
import 'package:chat/styles/styles.dart';
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
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _EmailInput(),
              _PasswordInput(),
              _ConfirmPasswordInput(),
              _SignUpButton(),
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
          onChanged: (String email) =>
              context.read<SignUpCubit>().emailChanged(email),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState previous, SignUpState current) =>
          previous.password != current.password,
      builder: (BuildContext context, SignUpState state) {
        return LoginDataInput(
          onChanged: (String password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          textInputAction: TextInputAction.next,
          obscureText: true,
          labelText: 'password',
          errorText:
              state.password.displayError != null ? 'invalid password' : null,
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
          onChanged: (String confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          onSubmitted: (_) => context.read<SignUpCubit>().signUpFormSubmitted(),
          obscureText: true,
          labelText: 'confirm password',
          errorText: state.confirmedPassword.displayError != null
              ? 'passwords do not match'
              : null,
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
        if (state.status.isInProgress) {
          return const CircularProgressIndicator();
        }

        return Padding(
          padding: style.padding ?? EdgeInsets.zero,
          child: ElevatedButton(
            onPressed: state.isValid
                ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                : null,
            style: style.style,
            child: const Text('SIGN UP'),
          ),
        );
      },
    );
  }
}
