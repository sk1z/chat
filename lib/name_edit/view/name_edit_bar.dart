import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/name_edit/name_edit.dart';

class NameEditBar extends StatelessWidget implements PreferredSizeWidget {
  const NameEditBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Edit name'),
      actions: [
        IconButton(
          icon: const Icon(Icons.done),
          onPressed: () => context.read<NameEditCubit>().editName(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => _appBar.preferredSize;

  static final AppBar _appBar = AppBar();
}
