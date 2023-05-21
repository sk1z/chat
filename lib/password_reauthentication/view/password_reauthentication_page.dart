import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/password_reauthentication/password_reauthentication.dart';

class PasswordReauthenticationPage extends StatelessWidget {
  const PasswordReauthenticationPage(
      {super.key, this.onPasswordConfirmed, this.helper});

  final void Function(String password)? onPasswordConfirmed;
  final String? helper;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordReauthenticationCubit(
          onPasswordConfirmed: onPasswordConfirmed),
      child: Scaffold(
        appBar: const PasswordReauthenticationBar(),
        body: PasswordReauthenticationForm(helper: helper),
      ),
    );
  }
}
