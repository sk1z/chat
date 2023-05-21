import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/password_reauthentication/password_reauthentication.dart';

class PasswordReauthenticationBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PasswordReauthenticationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Reauthentication'),
      actions: [
        IconButton(
          onPressed: () =>
              context.read<PasswordReauthenticationCubit>().passwordConfirmed(),
          icon: const Icon(Icons.done),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => _appBar.preferredSize;

  static final AppBar _appBar = AppBar();
}
