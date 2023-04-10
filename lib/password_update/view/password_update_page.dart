import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/account_data_update/account_data_update.dart';
import 'package:flutter_firebase_login/header/header.dart';
import 'package:flutter_firebase_login/item_box/item_box.dart';
import 'package:flutter_firebase_login/password_update/password_update.dart';

class PasswordUpdatePage extends StatelessWidget {
  const PasswordUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.flow<bool>().complete(),
        ),
        title: const Text('Password'),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<PasswordUpdateCubit>().updatePassword(),
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: Column(
        children: [
          ItemBox(
            child: Column(children: [
              const Header(
                mode: HeaderMode.wide,
                title: 'Set password',
              ),
              AccountDataInput(
                onChanged: (String password) => context
                    .read<PasswordUpdateCubit>()
                    .passwordChanged(password),
                obscureText: true,
                hintText: 'password',
              ),
            ]),
          ),
          const _PasswordValidator(),
          const AccountDataHelper(
            text: 'Password must contain at least 1 letter and 1 number. '
                'Minimum length is 8 characters.',
          ),
        ],
      ),
    );
  }
}

class _PasswordValidator extends StatelessWidget {
  const _PasswordValidator();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordUpdateCubit, PasswordUpdateState>(
      buildWhen: (PasswordUpdateState previous, PasswordUpdateState current) =>
          previous.password != current.password,
      builder: (BuildContext context, PasswordUpdateState state) {
        return AccountDataValidator(
          error: state.password.invalid ? 'invalid password' : null,
        );
      },
    );
  }
}
