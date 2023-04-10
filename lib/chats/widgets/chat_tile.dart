import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/styles/styles.dart';
import 'package:intl/intl.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.firstName,
    this.lastName,
    this.message,
    this.sentTime,
    this.now,
    this.onTap,
    this.onLongPress,
    this.divider = false,
  });

  final String firstName;
  final String? lastName;
  final String? message;
  final DateTime? sentTime;
  final DateTime? now;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool divider;

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

    final String? sentTime;
    if (this.sentTime != null && now != null) {
      final DateTime _sentTime = DateTime(
          this.sentTime!.year, this.sentTime!.month, this.sentTime!.day);
      final DateTime now =
          DateTime(this.now!.year, this.now!.month, this.now!.day);
      final int daysDifference = now.difference(_sentTime).inDays;

      if (daysDifference > 6) {
        sentTime = _dateFormat_MMMd.format(this.sentTime!);
      } else if (daysDifference > 0) {
        sentTime = _dateFormat_E.format(this.sentTime!);
      } else {
        sentTime = _dateFormat_Kmma.format(this.sentTime!);
      }
    } else {
      sentTime = null;
    }

    final ChatTileStyle style = Theme.of(context).extension<ChatTileStyle>()!;

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: SizedBox(
        height: style.height,
        child: Stack(
          children: [
            Padding(
              padding: style.contentPadding ?? EdgeInsets.zero,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: style.avatarWidth,
                    child: Container(
                      alignment: Alignment.center,
                      width: style.avatarSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: style.avatarColor,
                      ),
                      child: Text(
                        nameFirstLetters,
                        style: style.avatarTextStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              height: style.nameHeight,
                              child: Text(name, style: style.nameStyle),
                            ),
                            if (sentTime != null)
                              Container(
                                alignment: Alignment.bottomCenter,
                                padding: style.sentTimePadding,
                                height: style.sentTimeHeight,
                                child: Text(
                                  sentTime,
                                  style: style.sentTimeStyle,
                                ),
                              ),
                          ],
                        ),
                        if (message != null)
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: style.messagePadding,
                            child: Text(message!, style: style.messageStyle),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (divider)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: style.dividerPadding,
                  color: style.dividerColor,
                  height: style.dividerHeight,
                ),
              ),
          ],
        ),
      ),
    );
  }

  static final DateFormat _dateFormat_MMMd = DateFormat('MMM d');

  static final DateFormat _dateFormat_E = DateFormat('E');

  static final DateFormat _dateFormat_Kmma = DateFormat('K:mm a');
}
