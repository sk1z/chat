import 'package:flutter/material.dart';
import 'package:chat/styles/styles.dart';

class MessageSelectionCheckMark extends StatelessWidget {
  const MessageSelectionCheckMark({super.key, required this.messageSelected});

  final bool messageSelected;

  @override
  Widget build(BuildContext context) {
    final MessageSelectionCheckMarkStyle style =
        Theme.of(context).extension<MessageSelectionCheckMarkStyle>()!;

    return Container(
      width: style.size,
      height: style.size,
      margin: style.margin,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: messageSelected ? style.color : null,
        border: Border.all(color: style.borderColor ?? Colors.transparent),
      ),
      child: messageSelected
          ? Center(
              child: IconTheme(
                data: style.iconTheme ?? const IconThemeData(),
                child: const Icon(Icons.check),
              ),
            )
          : null,
    );
  }
}
