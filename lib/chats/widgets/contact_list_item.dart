import 'package:flutter/material.dart';

class ContactListItem extends StatelessWidget {
  const ContactListItem({
    required VoidCallback openChatOnTap,
  }) : _openChatOnTap = openChatOnTap;

  final VoidCallback _openChatOnTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _openChatOnTap,
      child: ListTile(
          // title: Text(_contact.name),
          ),
    );
  }
}
