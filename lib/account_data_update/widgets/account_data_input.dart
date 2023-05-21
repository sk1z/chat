import 'package:flutter/material.dart';
import 'package:chat/styles/styles.dart';

class AccountDataInput extends StatelessWidget {
  const AccountDataInput({
    super.key,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.hintText,
  });

  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmitted;
  final bool obscureText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final AccountDataInputStyle style =
        Theme.of(context).extension<AccountDataInputStyle>()!;

    return Padding(
      padding: style.padding ?? EdgeInsets.zero,
      child: TextField(
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        obscureText: obscureText,
        decoration: InputDecoration(hintText: hintText).applyDefaults(
            style.decorationTheme ?? const InputDecorationTheme()),
      ),
    );
  }
}
