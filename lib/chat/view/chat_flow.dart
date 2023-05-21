import 'package:firestore_repository/firestore_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/app_icons.dart';
import 'package:chat/chat/chat.dart';
import 'package:chat/message_menu/message_menu.dart';
import 'package:chat/chats/chats.dart';
import 'package:local_cache/local_cache.dart';

class ChatFlow extends StatelessWidget {
  const ChatFlow(
      {super.key, required this.contactId, required this.contactFirstName});

  final String contactId;
  final String contactFirstName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(
          contactId: contactId,
          localCache: context.read<LocalCacheClient>(),
          chatsCubit: context.read<ChatsCubit>(),
          firestoreUserRepository: context.read<FirestoreRepository>(),
          contactFirstName: contactFirstName),
      child: BlocBuilder<ChatCubit, ChatState>(
        buildWhen: (ChatState previous, ChatState current) =>
            (previous.selectStatus == ChatMessageSelectStatus.single ||
                current.selectStatus == ChatMessageSelectStatus.single) &&
            previous.messageHitPosition != current.messageHitPosition,
        builder: (BuildContext context, ChatState state) {
          return FlowBuilder(
            state: state,
            onGeneratePages: _onGeneratePages,
          );
        },
      ),
    );
  }
}

List<Page<dynamic>> _onGeneratePages(
    ChatState state, List<Page<dynamic>> pages) {
  return [
    const MaterialPage<void>(child: ChatPage()),
    if (state.selectStatus == ChatMessageSelectStatus.single)
      _TransitionPage(
        key: ValueKey('Chat bubble menu ${state.messageHitPosition}'),
        childBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return MessageMenu(
            position: state.messageHitPosition,
            animation: animation,
            onWillPop: () => context.read<ChatCubit>().messagesDeselected(),
            items: [
              MessageMenuItem(
                icon: const Icon(AppIcons.reply_outline),
                title: 'Reply',
              ),
              MessageMenuItem(
                icon: const Icon(Icons.copy),
                title: 'Copy',
              ),
              MessageMenuItem(
                icon: const Icon(AppIcons.forward_outline),
                title: 'Forward',
              ),
              MessageMenuItem(
                icon: const Icon(AppIcons.pin_outline),
                title: 'Pin',
              ),
              MessageMenuItem(
                onTap: () => context.read<ChatCubit>().deleteMessage(),
                icon: const Icon(AppIcons.trash),
                title: 'Delete',
              ),
            ],
          );
        },
      ),
  ];
}

class _TransitionPage extends Page<void> {
  const _TransitionPage({super.key, required this.childBuilder});

  final RoutePageBuilder childBuilder;

  @override
  Route<void> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      opaque: false,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 170),
      reverseTransitionDuration: const Duration(milliseconds: 170),
      pageBuilder: childBuilder,
    );
  }
}
