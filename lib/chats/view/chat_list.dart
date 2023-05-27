import 'package:boxy/slivers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/chats/chats.dart';
import 'package:chat/contact/contact.dart';
import 'package:chat/header/header.dart';
import 'package:chat/item_box/item_box.dart';
import 'package:chat/item_divider/item_divider.dart';
import 'package:chat/styles/styles.dart';
import 'package:go_router/go_router.dart';
import 'package:local_cache/local_cache.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key, required this.chats});

  final List<ChatWithLastMessage> chats;

  @override
  Widget build(BuildContext context) {
    void openChatPage(String contactId, String contactFirstName) {
      context.go('/chats/$contactId?contact_first_name=$contactFirstName');
    }

    final DateTime now = DateTime.now();

    // final List<ChatWithLastMessage> chats = createChats(now);

    int? firstContact;
    for (int i = 0; i < chats.length; i++) {
      if (chats[i].message == null) {
        firstContact = i;
        break;
      }
    }

    final ChatTileStyle chatTileStyle =
        Theme.of(context).extension<ChatTileStyle>()!;
    final ContactTileStyle contactTileStyle =
        Theme.of(context).extension<ContactTileStyle>()!;

    const Widget sliverFillRemaining = SliverFillRemaining(
      hasScrollBody: false,
      child: SizedBox.shrink(),
    );

    return CustomScrollView(slivers: [
      SliverContainer(
        background: const ItemBox(),
        sliver: MultiSliver(children: [
          SliverFixedExtentList(
            itemExtent: chatTileStyle.height ?? 100,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final ChatWithLastMessage chat = chats[index];

                return ChatTile(
                  onTap: () =>
                      openChatPage(chat.contactId, chat.contactFirstName),
                  onLongPress: () =>
                      context.read<ChatsCubit>().clearChat(chat.id),
                  firstName: chat.contactFirstName,
                  message: chat.message,
                  sentTime: chat.messageSentTime,
                  now: now,
                  divider: index < (firstContact ?? chats.length) - 1,
                );
              },
              childCount: firstContact ?? chats.length,
            ),
          ),
          if (firstContact == null) sliverFillRemaining,
        ]),
      ),
      if (firstContact != null && firstContact > 0)
        const SliverToBoxAdapter(child: ItemDivider()),
      if (firstContact != null)
        SliverContainer(
          background: const ItemBox(),
          sliver: MultiSliver(children: [
            const SliverToBoxAdapter(
              child: Header(
                mode: HeaderMode.wide,
                title: 'Your contacts',
              ),
            ),
            SliverFixedExtentList(
              itemExtent: contactTileStyle.height ?? 100,
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
            sliverFillRemaining,
          ]),
        ),
    ]);
  }
}

List<ChatWithLastMessage> createChats(DateTime time) {
  return [
    ChatWithLastMessage(
      id: '0',
      contactId: '0',
      contactFirstName: 'Hari',
      messageUid: '0',
      message: 'Effd',
      messageSentTime: time,
    ),
    ChatWithLastMessage(
      id: '2',
      contactId: '2',
      contactFirstName: 'Emm',
      message: 'zz',
      messageSentTime: time.add(const Duration(
        days: -6,
      )),
    ),
    ChatWithLastMessage(
      id: '3',
      contactId: '3',
      contactFirstName: 'Oi',
      messageUid: '3',
      message: 'Hi',
      messageSentTime: time.add(const Duration(
        hours: -1,
      )),
    ),
    ChatWithLastMessage(
      id: '3',
      contactId: '3',
      contactFirstName: 'Josefin',
      messageUid: '3',
      message: 'Hi',
      messageSentTime: time.add(const Duration(
        hours: -1,
      )),
    ),
    ChatWithLastMessage(
      id: '4',
      contactId: '4',
      contactFirstName: 'He',
      messageUid: '4',
      message: 'chto',
      messageSentTime: time.add(const Duration(
        days: -1,
      )),
    ),
    ChatWithLastMessage(
      id: '5',
      contactId: '5',
      contactFirstName: 'Heh',
      messageUid: '5',
      message: 'la la',
      messageSentTime: time.add(const Duration(
        days: -7,
        minutes: -1,
      )),
    ),
    ChatWithLastMessage(
      id: '5',
      contactId: '5',
      contactFirstName: 'Lukas',
      messageUid: '5',
    ),
    ChatWithLastMessage(
      id: '6',
      contactId: '5',
      contactFirstName: 'Lukas',
      messageUid: '5',
    ),
    ChatWithLastMessage(
      id: '7',
      contactId: '5',
      contactFirstName: 'Lukas',
      messageUid: '5',
    ),
    ChatWithLastMessage(
      id: '8',
      contactId: '5',
      contactFirstName: 'Lukas',
      messageUid: '5',
    ),
    ChatWithLastMessage(
      id: '9',
      contactId: '5',
      contactFirstName: 'Lukas',
      messageUid: '5',
    ),
    ChatWithLastMessage(
      id: '10',
      contactId: '5',
      contactFirstName: 'Lukas',
      messageUid: '5',
    ),
    ChatWithLastMessage(
      id: '11',
      contactId: '5',
      contactFirstName: 'Lukas',
      messageUid: '5',
    ),
  ];
}
