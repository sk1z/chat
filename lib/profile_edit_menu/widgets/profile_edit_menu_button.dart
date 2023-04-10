import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/profile_edit_menu/profile_edit_menu.dart';

typedef _ProfileEditMenuItemBuilder<T> = List<Widget> Function();

const Duration _menuTransitionDuration = Duration(milliseconds: 150);
const Duration _menuReverseTransitionDuration = Duration(milliseconds: 150);

class ProfileEditMenuButton extends StatefulWidget {
  const ProfileEditMenuButton({super.key, required this.itemBuilder});

  final _ProfileEditMenuItemBuilder itemBuilder;

  @override
  _ProfileEditMenuButtonState createState() => _ProfileEditMenuButtonState();
}

class _ProfileEditMenuButtonState extends State<ProfileEditMenuButton> {
  void showMenu() {
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final Offset position = button.localToGlobal(Offset.zero);

    final List<Widget> items = widget.itemBuilder();

    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      barrierDismissible: true,
      transitionDuration: _menuTransitionDuration,
      reverseTransitionDuration: _menuReverseTransitionDuration,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return CustomSingleChildLayout(
          delegate: ProfileEditMenuRouteLayout(position),
          child: ProfileEditMenu(
            animation: animation,
            items: items,
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: showMenu,
      icon: Icon(Icons.adaptive.more),
    );
  }
}
