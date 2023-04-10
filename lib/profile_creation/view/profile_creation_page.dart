import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/app/app.dart';
import 'package:flutter_firebase_login/profile_creation/profile_creation.dart';
import 'package:flutter_firebase_login/styles/styles.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';

class ProfileCreationPage extends StatelessWidget {
  const ProfileCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileCreationPageStyle style =
        Theme.of(context).extension<ProfileCreationPageStyle>()!;

    return BlocProvider(
      create: (_) => ProfileCreationCubit(
          firestoreRepository: context.read<FirestoreRepository>()),
      child: BlocListener<ProfileCreationCubit, ProfileCreationState>(
        listener: (BuildContext context, ProfileCreationState state) {
          if (state.status.isSubmissionFailure) {
            Fluttertoast.cancel();
            Fluttertoast.showToast(
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              msg: 'Profile Creation Failure',
            );
          }
        },
        child: Scaffold(
          backgroundColor: style.backgroundColor,
          appBar: AppBar(
            leading: BackButton(
              onPressed: () =>
                  context.read<AppBloc>().add(AppLogoutRequested()),
            ),
            title: const Text('Create Profile'),
          ),
          body: const ProfileCreationForm(),
          floatingActionButton: const ProfileCreationSubmitButton(),
        ),
      ),
    );
  }
}
