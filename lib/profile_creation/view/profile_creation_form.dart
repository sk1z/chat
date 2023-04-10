import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/name_edit/name_edit.dart';
import 'package:flutter_firebase_login/profile_creation/profile_creation.dart';
import 'package:flutter_firebase_login/styles/styles.dart';

class ProfileCreationForm extends StatelessWidget {
  const ProfileCreationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileCreationFormStyle style =
        Theme.of(context).extension<ProfileCreationFormStyle>()!;

    return Padding(
      padding: style.padding ?? EdgeInsets.zero,
      child: Column(
        children: [
          NameInput(
            hintText: 'First name (required)',
            onChanged: (String firstName) => context
                .read<ProfileCreationCubit>()
                .firstNameChanged(firstName),
            textInputAction: TextInputAction.next,
          ),
          NameInput(
            hintText: 'Last name (optional)',
            onChanged: (String lastName) =>
                context.read<ProfileCreationCubit>().lastNameChanged(lastName),
            onSubmitted: (_) =>
                context.read<ProfileCreationCubit>().createProfile(),
          ),
        ],
      ),
    );
  }
}
