import 'package:flutter/material.dart';
import 'package:chat/styles/styles.dart';

class AccountDataHelper extends StatelessWidget {
  const AccountDataHelper({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final AccountDataHelperStyle style =
        Theme.of(context).extension<AccountDataHelperStyle>()!;

    return Container(
      alignment: style.alignment,
      padding: style.padding,
      child: Text(text, style: style.textStyle),
    );
  }
}
