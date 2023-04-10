import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/name_edit/name_edit.dart';
import 'package:flutter_firebase_login/styles/styles.dart';

class NameEditForm extends StatelessWidget {
  const NameEditForm({super.key});

  @override
  Widget build(BuildContext context) {
    final NameEditState state = context.read<NameEditCubit>().state;

    final NameEditFormStyle style =
        Theme.of(context).extension<NameEditFormStyle>()!;

    return Padding(
      padding: style.padding ?? EdgeInsets.zero,
      child: Column(
        children: [
          NameInput(
            hintText: 'First name (required)',
            initialName: state.firstName.value,
            onChanged: (String firstName) =>
                context.read<NameEditCubit>().firstNameChanged(firstName),
            textInputAction: TextInputAction.next,
          ),
          NameInput(
            hintText: 'Last name (optional)',
            initialName: state.lastName.value,
            onChanged: (String lastName) =>
                context.read<NameEditCubit>().lastNameChanged(lastName),
            onSubmitted: (_) => context.read<NameEditCubit>().editName(),
          ),
        ],
      ),
    );
  }
}
