import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/account_data_update/account_data_update.dart';
import 'package:chat/header/header.dart';
import 'package:chat/item_box/item_box.dart';
import 'package:chat/password_reauthentication/password_reauthentication.dart';

class PasswordReauthenticationForm extends StatelessWidget {
  const PasswordReauthenticationForm({super.key, this.helper});

  final String? helper;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemBox(
          child: Column(children: [
            const Header(
              mode: HeaderMode.wide,
              title: 'Your password',
            ),
            AccountDataInput(
              onChanged: (String password) => context
                  .read<PasswordReauthenticationCubit>()
                  .passwordChanged(password),
              onSubmitted: (_) => context
                  .read<PasswordReauthenticationCubit>()
                  .passwordConfirmed(),
              obscureText: true,
              hintText: 'password',
            ),
          ]),
        ),
        const _PasswordValidator(),
        if (helper != null) AccountDataHelper(text: helper!),
      ],
    );
  }
}

class _PasswordValidator extends StatelessWidget {
  const _PasswordValidator();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordReauthenticationCubit,
        PasswordReauthenticationState>(
      buildWhen: (PasswordReauthenticationState previous,
              PasswordReauthenticationState current) =>
          previous.password != current.password,
      builder: (BuildContext context, PasswordReauthenticationState state) {
        return AccountDataValidator(
          error: state.password.invalid ? 'invalid password' : null,
        );
      },
    );
  }
}
