import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/chat/chat.dart';
import 'package:flutter_firebase_login/contact/contact.dart';
import 'package:flutter_firebase_login/flip_counter/flip_counter.dart';

class ChatBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (ChatState previous, ChatState current) =>
          previous.selectedMessagesLength != current.selectedMessagesLength,
      builder: (BuildContext context, ChatState state) {
        if (state.selectStatus == ChatMessageSelectStatus.multi) {
          return AppBar(
            titleSpacing: 0,
            leading: IconButton(
              onPressed: () => context.read<ChatCubit>().messagesDeselected(),
              icon: const Icon(Icons.cancel_outlined),
            ),
            title: RepaintBoundary(
              child: FlipCounter(
                value: state.selectedMessagesLength,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => context.read<ChatCubit>().deleteMessages(),
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          );
        }

        return AppBar(
          titleSpacing: 0,
          leading: BackButton(
            onPressed: () => context.flow<ChatState>().complete(),
          ),
          title: InkWell(
            onTap: () => context.read<ChatCubit>().createMessages(),
            child: ContactTile(
              mode: ContactTileMode.appBar,
              firstName: state.contactFirstName,
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => _appBar.preferredSize;

  static final _appBar = AppBar();
}
