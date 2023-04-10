import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/account_data_update/account_data_update.dart';
import 'package:flutter_firebase_login/email_update/email_update.dart';
import 'package:flutter_firebase_login/header/header.dart';
import 'package:flutter_firebase_login/item_box/item_box.dart';

class EmailUpdatePage extends StatelessWidget {
  const EmailUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.flow<bool>().complete(),
        ),
        title: const Text('Email'),
        actions: [
          IconButton(
            onPressed: () => context.read<EmailUpdateCubit>().updateEmail(),
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
                // title: 'Set username',
                title: 'Update email',
              ),
              AccountDataInput(
                onChanged: (String email) =>
                    context.read<EmailUpdateCubit>().emailChanged(email),
                // hintText: 't.me/username',
                hintText: 'email',
              ),
            ]),
          ),
          const _EmailValidator(),
        ],
      ),
    );
  }
}

class _EmailValidator extends StatelessWidget {
  const _EmailValidator();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailUpdateCubit, EmailUpdateState>(
      buildWhen: (EmailUpdateState previous, EmailUpdateState current) =>
          previous.email != current.email,
      builder: (BuildContext context, EmailUpdateState state) {
        return AccountDataValidator(
          // error: 'Usernames',
          error: state.email.invalid ? 'invalid email' : null,
        );
      },
    );
  }
}
