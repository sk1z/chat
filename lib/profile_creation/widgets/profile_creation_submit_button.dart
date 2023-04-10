import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/profile_creation/profile_creation.dart';
import 'package:flutter_firebase_login/styles/styles.dart';
import 'package:formz/formz.dart';

class ProfileCreationSubmitButton extends StatelessWidget {
  const ProfileCreationSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileCreationSubmitButtonStyle style =
        Theme.of(context).extension<ProfileCreationSubmitButtonStyle>()!;

    return BlocBuilder<ProfileCreationCubit, ProfileCreationState>(
      buildWhen:
          (ProfileCreationState previous, ProfileCreationState current) =>
              previous.status != current.status &&
              (previous.status.isSubmissionInProgress ||
                  current.status.isSubmissionInProgress),
      builder: (BuildContext context, ProfileCreationState state) {
        if (state.status.isSubmissionInProgress) {
          return const FloatingActionButton(
            onPressed: null,
            backgroundColor: Colors.transparent,
            child: CircularProgressIndicator(),
          );
        }

        return FloatingActionButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.read<ProfileCreationCubit>().createProfile();
          },
          child: IconTheme(
            data: style.iconTheme ?? const IconThemeData(),
            child: const Icon(Icons.check),
          ),
        );
      },
    );
  }
}
