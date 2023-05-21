import 'package:flutter/material.dart';
import 'package:chat/chat/chat.dart';
import 'package:chat/styles/styles.dart';

class MessageListItem extends StatefulWidget {
  const MessageListItem({
    required this.messageId,
    required this.isMyMessage,
    required this.messageContent,
    required this.messageLastUpdated,
    this.singleMessageSelected = false,
    this.multiMessagesSelected = false,
    this.messageSelected = false,
    this.hitPosition,
    this.onTap,
    required this.maxWidth,
  });

  final String messageId;
  final bool isMyMessage;
  final String messageContent;
  final DateTime messageLastUpdated;
  final bool singleMessageSelected;
  final bool multiMessagesSelected;
  final bool messageSelected;
  final Offset? hitPosition;
  final ValueChanged<TapUpDetails>? onTap;
  final double maxWidth;

  @override
  State<MessageListItem> createState() => _MessageListItemState();
}

class _MessageListItemState extends State<MessageListItem>
    with SingleTickerProviderStateMixin<MessageListItem> {
  late AnimationController _controller;
  late Animation<double> _highlightRadiusFactor;

  Offset? _hitPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        value: widget.messageSelected ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        vsync: this);
    _highlightRadiusFactor =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void didUpdateWidget(covariant MessageListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.messageSelected != widget.messageSelected) {
      _hitPosition = widget.hitPosition;
      if (widget.messageSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MessageHighlightStyle style =
        Theme.of(context).extension<MessageHighlightStyle>()!;

    return GestureDetector(
      onTapUp: widget.onTap,
      child: MessageHighlight(
        radius: _highlightRadiusFactor,
        hitPosition: _hitPosition,
        color: style.color,
        child: Row(
          mainAxisAlignment: widget.isMyMessage
              ? widget.multiMessagesSelected
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (widget.multiMessagesSelected)
              MessageSelectionCheckMark(
                  messageSelected: widget.messageSelected),
            MessageBubble(
              messageId: widget.messageId,
              isMyMessage: widget.isMyMessage,
              messageContent: widget.messageContent,
              messageLastUpdated: widget.messageLastUpdated,
              singleMessageSelected: widget.singleMessageSelected,
              multiMessagesSelected: widget.multiMessagesSelected,
              messageSelected: widget.messageSelected,
              maxWidth: widget.maxWidth,
            ),
          ],
        ),
      ),
    );
  }
}
