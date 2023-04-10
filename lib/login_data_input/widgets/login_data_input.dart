import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/styles/styles.dart';

class LoginDataInput extends StatelessWidget {
  const LoginDataInput({
    super.key,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.keyboardType,
    this.obscureText = false,
    this.labelText,
    this.errorText,
  });

  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmitted;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? labelText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final LoginDataInputStyle style =
        Theme.of(context).extension<LoginDataInputStyle>()!;

    return Padding(
      padding: style.padding ?? EdgeInsets.zero,
      child: TextField(
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          helperText: '',
          errorText: errorText,
        ).applyDefaults(style.decorationTheme ?? const InputDecorationTheme()),
      ),
    );
  }
}
