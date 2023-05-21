import 'package:flutter/material.dart';
import 'package:chat/styles/styles.dart';
import 'package:intl/intl.dart';

enum ContactTileMode { list, appBar }

class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.firstName,
    this.lastName,
    this.lastSeen,
    this.now,
    this.onTap,
    this.mode = ContactTileMode.list,
  });

  final String firstName;
  final String? lastName;
  final DateTime? lastSeen;
  final DateTime? now;
  final VoidCallback? onTap;
  final ContactTileMode mode;

  @override
  Widget build(BuildContext context) {
    final String firstNameFirstLetter =
        firstName.isNotEmpty ? firstName.substring(0, 1) : '';
    final String lastNameFirstLetter = lastName != null && lastName!.isNotEmpty
        ? lastName!.substring(0, 1)
        : '';
    final String nameFirstLetters =
        (firstNameFirstLetter + lastNameFirstLetter).toUpperCase();

    final String name = '$firstName ${lastName ?? ''}';

    final String lastSeenStatus;

    if (lastSeen != null && now != null) {
      final DateTime _lastSeen = DateTime(
          this.lastSeen!.year, this.lastSeen!.month, this.lastSeen!.day);
      final DateTime _now =
          DateTime(this.now!.year, this.now!.month, this.now!.day);
      final int daysDifference = _now.difference(_lastSeen).inDays;

      if (daysDifference > 1) {
        lastSeenStatus = 'last seen ${_dateFormat_MMMd.format(lastSeen!)}'
            ' at ${_dateFormat_Kmma.format(lastSeen!)}';
      } else if (daysDifference > 0) {
        lastSeenStatus =
            'last seen yesterday at ${_dateFormat_Kmma.format(lastSeen!)}';
      } else if (now!.difference(lastSeen!).inMinutes > 5) {
        lastSeenStatus = 'last seen at ${_dateFormat_Kmma.format(lastSeen!)}';
      } else {
        lastSeenStatus = 'online';
      }
    } else {
      lastSeenStatus = 'last seen recently';
    }

    final ContactTileStyle style =
        Theme.of(context).extension<ContactTileStyle>()!;

    final EdgeInsetsGeometry? contentPadding;
    final double? avatarWidth;
    final double? avatarSize;
    final TextStyle? avatarTextStyle;
    final TextStyle? nameStyle;
    final double? nameHeight;
    final EdgeInsetsGeometry? lastSeenPadding;

    switch (mode) {
      case ContactTileMode.list:
        contentPadding = style.contentPadding;
        avatarWidth = style.avatarWidth;
        avatarSize = style.avatarSize;
        avatarTextStyle = style.avatarTextStyle;
        nameStyle = style.nameStyle;
        nameHeight = style.nameHeight;
        lastSeenPadding = style.lastSeenPadding;
        break;
      case ContactTileMode.appBar:
        contentPadding = style.appBarContentPadding ?? style.contentPadding;
        avatarWidth = style.appBarAvatarWidth ?? style.avatarWidth;
        avatarSize = style.appBarAvatarSize ?? style.avatarSize;
        avatarTextStyle =
            style.avatarTextStyle?.merge(style.appBarAvatarTextStyle) ??
                style.appBarAvatarTextStyle;
        nameStyle = style.nameStyle?.merge(style.appBarNameStyle) ??
            style.appBarNameStyle;
        nameHeight = style.appBarNameHeight ?? style.nameHeight;
        lastSeenPadding = style.appBarLastSeenPadding ?? style.lastSeenPadding;
        break;
    }

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: style.height,
          padding: contentPadding,
          child: Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: avatarWidth,
                child: Container(
                  alignment: Alignment.center,
                  width: avatarSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: style.avatarColor,
                  ),
                  child: Text(nameFirstLetters, style: avatarTextStyle),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    height: nameHeight,
                    child: Text(name, style: nameStyle),
                  ),
                  Padding(
                    padding: lastSeenPadding ?? EdgeInsets.zero,
                    child: Text(
                      lastSeenStatus,
                      style: lastSeenStatus == 'online'
                          ? style.onlineStyle
                          : style.lastSeenStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static final DateFormat _dateFormat_MMMd = DateFormat('MMM d');

  static final DateFormat _dateFormat_Kmma = DateFormat('K:mm a');
}
