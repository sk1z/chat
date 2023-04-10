import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/name_edit/name_edit.dart';
import 'package:flutter_firebase_login/styles/styles.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';

class NameEditPage extends StatelessWidget {
  const NameEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NameEditPageStyle style =
        Theme.of(context).extension<NameEditPageStyle>()!;

    return BlocProvider(
      create: (_) => NameEditCubit(
          firestoreRepository: context.read<FirestoreRepository>()),
      child: BlocListener<NameEditCubit, NameEditState>(
        listener: (BuildContext context, NameEditState state) {
          if (state.status.isSubmissionSuccess) {
            Navigator.pop(context);
          } else if (state.status.isSubmissionFailure) {
            Fluttertoast.cancel();
            Fluttertoast.showToast(
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              msg: 'Name Edit Failure',
            );
          }
        },
        child: Scaffold(
          backgroundColor: style.backgroundColor,
          appBar: const NameEditBar(),
          body: const NameEditForm(),
        ),
      ),
    );
  }
}
