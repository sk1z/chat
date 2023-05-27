import 'package:flutter/material.dart';
import 'package:chat/styles/styles.dart';

class ProfileEditMenuItem extends StatelessWidget {
  const ProfileEditMenuItem(
      {super.key, required this.icon, required this.title, this.onTap});

  final Icon icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ProfileEditMenuItemStyle style =
        Theme.of(context).extension<ProfileEditMenuItemStyle>()!;

    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap?.call();
      },
      child: Container(
        height: style.height,
        padding: style.contentPadding,
        child: Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: style.iconWidth,
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
