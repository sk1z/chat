import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/chat/chat.dart';
import 'package:chat/styles/styles.dart';

class MessageInput extends StatelessWidget {
  MessageInput({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void sendMessage() {
      final String message = controller.value.text;
      if (message.isEmpty) return;
      controller.clear();
      FocusScope.of(context).unfocus();
      context.read<ChatCubit>().addMessage(message);
    }

    final MessageInputStyle style =
        Theme.of(context).extension<MessageInputStyle>()!;

    return Container(
      constraints: style.constraints,
      color: style.color,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: style.messagePadding ?? EdgeInsets.zero,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: style.cursorColor,
                decoration: const InputDecoration(hintText: 'Message')
                    .applyDefaults(style.messageDecorationTheme ??
                        const InputDecorationTheme()),
                style: style.messageStyle,
              ),
            ),
          ),
          IconButton(
            padding: style.sendButtonPadding ?? EdgeInsets.zero,
            icon: IconTheme(
              data: style.sendButtonIconTheme ?? const IconThemeData(),
              child: const Icon(Icons.send),
            ),
            onPressed: sendMessage,
          )
        ],
      ),
    );
  }
}
