import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/chat/chat.dart';
import 'package:flutter_firebase_login/styles/styles.dart';
import 'package:message_selector/message_selector.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    final MessageListStyle style =
        Theme.of(context).extension<MessageListStyle>()!;

    return MessageSelectionController(
      onSelectionStart: (String messageId, Offset hitPosition) {
        context
            .read<ChatCubit>()
            .longPressSelectionStarted(messageId, hitPosition);
      },
      onSelectionUpdate: (String messageId, Offset hitPosition) {
        context
            .read<ChatCubit>()
            .longPressSelectionUpdated(messageId, hitPosition);
      },
      onSelectionEnd: (String messageId, Offset hitPosition) {
        context
            .read<ChatCubit>()
            .longPressSelectionEnded(messageId, hitPosition);
      },
      builder: (BuildContext context, ScrollController scrollController) {
        return LayoutBuilder(builder: (
          BuildContext context,
          BoxConstraints constraints,
        ) {
          return BlocBuilder<ChatCubit, ChatState>(
            buildWhen: (ChatState previous, ChatState current) =>
                previous.messages != current.messages,
            builder: (BuildContext context, ChatState state) {
              return ListView.builder(
                padding: style.padding,
                controller: scrollController,
                itemCount: state.messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final Message message = state.messages[index];

                  return MetaData(
                    metaData: MessageSelectionMetaData(messageId: message.id),
                    child: MessageListItem(
                      messageId: message.id,
                      isMyMessage: message.isMy,
                      messageContent: message.message,
                      messageLastUpdated: message.lastUpdated,
                      singleMessageSelected:
                          message.selectStatus == MessageSelectStatus.single,
                      multiMessagesSelected:
                          state.selectStatus == ChatMessageSelectStatus.multi,
                      messageSelected:
                          message.selectStatus == MessageSelectStatus.selected,
                      hitPosition: state.messageHitPosition,
                      onTap: (TapUpDetails details) => context
                          .read<ChatCubit>()
                          .messageSelected(message.id, details.globalPosition),
                      maxWidth: constraints.maxWidth,
                    ),
                  );
                },
              );
            },
          );
        });
      },
    );
  }
}
