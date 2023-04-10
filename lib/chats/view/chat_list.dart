import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/chats/chats.dart';
import 'package:flutter_firebase_login/contact/contact.dart';
import 'package:flutter_firebase_login/header/header.dart';
import 'package:flutter_firebase_login/item_divider/item_divider.dart';
import 'package:go_router/go_router.dart';
import 'package:local_cache/local_cache.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key, required this.chats});

  final List<ChatWithLastMessage> chats;

  @override
  Widget build(BuildContext context) {
    void openChatPage(String contactId, String contactFirstName) {
      context.go('/chats/${contactId}?contact_first_name=${contactFirstName}');
    }

    final DateTime now = DateTime.now();

    // final List<ChatWithLastMessage> chats = createChats(now);

    int? firstContact = null;
    for (int i = 0; i < chats.length; i++) {
      if (chats[i].message == null) {
        firstContact = i;
        break;
      }
    }

    return CustomScrollView(slivers: [
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final ChatWithLastMessage chat = chats[index];

            return ChatTile(
              onTap: () => openChatPage(chat.contactId, chat.contactFirstName),
              onLongPress: () => context.read<ChatsCubit>().clearChat(chat.id),
              firstName: chat.contactFirstName,
              message: chat.message,
              sentTime: chat.messageSentTime,
              now: now,
              divider: firstContact != null ? index < firstContact - 1 : false,
            );
          },
          childCount: firstContact ?? chats.length,
        ),
      ),
      const SliverToBoxAdapter(child: ItemDivider()),
      if (firstContact != null) ...[
        const SliverToBoxAdapter(
          child: Header(
            mode: HeaderMode.wide,
            title: 'Your contacts',
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final ChatWithLastMessage chat = chats[firstContact! + index];

              return ContactTile(
                onTap: () =>
                    openChatPage(chat.contactId, chat.contactFirstName),
                firstName: chat.contactFirstName,
              );
            },
            childCount: chats.length - firstContact,
          ),
        ),
      ]
    ]);
  }
}

List<ChatWithLastMessage> createChats(DateTime time) {
  return [
    ChatWithLastMessage(
      id: '0',
      contactId: '0',
      contactFirstName: 'Pasha',
      messageUid: '0',
      message: 'Effd',
      messageSentTime: time,
    ),
    ChatWithLastMessage(
      id: '2',
      contactId: '2',
      contactFirstName: '',
      message: 'zz',
      messageSentTime: time.add(Duration(
        days: -6,
      )),
    ),
    ChatWithLastMessage(
      id: '3',
      contactId: '3',
      contactFirstName: 'Lam',
      messageUid: '3',
      message: 'Hi',
      messageSentTime: time.add(Duration(
        hours: -1,
      )),
    ),
    ChatWithLastMessage(
      id: '3',
      contactId: '3',
      contactFirstName: 'Lapusik',
      messageUid: '3',
      message: 'Hi',
      messageSentTime: time.add(Duration(
        hours: -1,
      )),
    ),
    ChatWithLastMessage(
      id: '4',
      contactId: '4',
      contactFirstName: 'Kavo',
      messageUid: '4',
      message: 'chto',
      messageSentTime: time.add(Duration(
        days: -1,
      )),
    ),
    ChatWithLastMessage(
      id: '5',
      contactId: '5',
      contactFirstName: 'Tavo',
      messageUid: '5',
      message: 'la la',
      messageSentTime: time.add(Duration(
        days: -7,
        minutes: -1,
      )),
    ),
    ChatWithLastMessage(
      id: '5',
      contactId: '5',
      contactFirstName: 'Mmm',
      messageUid: '5',
    ),
    ChatWithLastMessage(
      id: '5',
      contactId: '5',
      contactFirstName: 'Mmm',
      messageUid: '5',
    ),
    ChatWithLastMessage(
      id: '5',
      contactId: '5',
      contactFirstName: 'Mmm',
      messageUid: '5',
    ),
    ChatWithLastMessage(
      id: '5',
      contactId: '5',
      contactFirstName: 'Mmm',
      messageUid: '5',
    ),
    ChatWithLastMessage(
      id: '5',
      contactId: '5',
      contactFirstName: 'Mmm',
      messageUid: '5',
    ),
    ChatWithLastMessage(
      id: '5',
      contactId: '5',
      contactFirstName: 'Mmm',
      messageUid: '5',
    ),
    ChatWithLastMessage(
      id: '5',
      contactId: '5',
      contactFirstName: 'Mmm',
      messageUid: '5',
    ),
    ChatWithLastMessage(
      id: '5',
      contactId: '5',
      contactFirstName: 'heh',
      messageUid: '5',
    ),
  ];
}
