import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/styles/styles.dart';

class AccountDataValidator extends StatelessWidget {
  const AccountDataValidator({super.key, this.error});

  final String? error;

  @override
  Widget build(BuildContext context) {
    final AccountDataValidatorStyle style =
        Theme.of(context).extension<AccountDataValidatorStyle>()!;

    if (error == null) {
      return const SizedBox.shrink();
    }

    return Container(
      alignment: style.alignment,
      padding: style.padding,
      child: Text(error!, style: style.errorStyle),
    );
  }
}
