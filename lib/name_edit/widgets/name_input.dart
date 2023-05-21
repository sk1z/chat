import 'package:flutter/material.dart';
import 'package:chat/styles/styles.dart';

class NameInput extends StatelessWidget {
  const NameInput({
    super.key,
    this.hintText,
    this.initialName,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
  });

  final String? hintText;
  final String? initialName;
  final void Function(String name)? onChanged;
  final void Function(String name)? onSubmitted;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final NameInputStyle style = Theme.of(context).extension<NameInputStyle>()!;

    return Padding(
      padding: style.padding ?? EdgeInsets.zero,
      child: TextFormField(
        initialValue: initialName,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(hintText: hintText).applyDefaults(
            style.decorationTheme ?? const InputDecorationTheme()),
        textCapitalization: TextCapitalization.sentences,
        style: style.textStyle,
      ),
    );
  }
}
