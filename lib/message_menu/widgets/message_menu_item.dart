import 'package:flutter/material.dart';
import 'package:chat/styles/styles.dart';

class MessageMenuItem extends StatelessWidget {
  const MessageMenuItem({required this.icon, required this.title, this.onTap});

  final Icon icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final MessageMenuItemStyle style =
        Theme.of(context).extension<MessageMenuItemStyle>()!;

    return InkWell(
      onTap: () => onTap?.call(),
      child: SizedBox(
        height: style.height,
        child: Row(
          children: [
            Padding(
              padding: style.iconPadding ?? EdgeInsets.zero,
              child: IconTheme(
                data: style.iconTheme ?? const IconThemeData(),
                child: icon,
              ),
            ),
            Text(title, style: style.titleStyle),
          ],
        ),
      ),
    );
  }
}
