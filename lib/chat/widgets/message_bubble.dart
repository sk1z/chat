import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/chat/chat.dart';
import 'package:flutter_firebase_login/styles/styles.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({
    required this.messageId,
    required this.isMyMessage,
    required this.messageContent,
    required this.messageLastUpdated,
    this.singleMessageSelected = false,
    this.multiMessagesSelected = false,
    this.messageSelected = false,
    required this.maxWidth,
  });

  final String messageId;
  final bool isMyMessage;
  final String messageContent;
  final DateTime messageLastUpdated;
  final bool singleMessageSelected;
  final bool multiMessagesSelected;
  final bool messageSelected;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final MessageBubbleStyle style =
        Theme.of(context).extension<MessageBubbleStyle>()!;

    return Flexible(
      child: Container(
        margin: style.margin,
        padding: style.padding,
        decoration: BoxDecoration(
          borderRadius: style.borderRadius != null
              ? BorderRadius.circular(style.borderRadius!)
              : null,
          color: singleMessageSelected
              ? isMyMessage
                  ? style.myMessageHighlightColor
                  : style.contactMessageHighlightColor
              : isMyMessage
                  ? style.myMessageColor
                  : style.contactMessageColor,
        ),
        child: InnerMessageBubble(
          text: TextSpan(
            text: messageContent,
            style: style.messageContentStyle,
          ),
          textDirection: ui.TextDirection.ltr,
          maxWidthPercentage: style.maxWidthPercentage ?? 75,
          maxWidth: maxWidth -
              (style.margin?.horizontal ?? 0) -
              (style.padding?.horizontal ?? 0),
          child: Padding(
            padding: style.messageLastUpdatedPadding ?? EdgeInsets.zero,
            child: Text(
              _messageLastUpdatedFormat.format(messageLastUpdated),
              style: isMyMessage
                  ? style.myMessageLastUpdateStyle
                  : style.contactMessageLastUpdateStyle,
            ),
          ),
        ),
      ),
    );
  }

  static final DateFormat _messageLastUpdatedFormat = DateFormat('hh:mm');
}
