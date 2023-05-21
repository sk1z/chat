import 'package:boxy/slivers.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:chat/contact/contact.dart';
import 'package:chat/item_box/item_box.dart';
import 'package:chat/styles/styles.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key, required this.contacts});

  final List<Profile> contacts;

  @override
  Widget build(BuildContext context) {
    void openChatPage(String contactId, String contactFirstName) {
      context.go('/chats/${contactId}?contact_first_name=${contactFirstName}');
    }

    final DateTime now = DateTime.now();

    // final List<Profile> contacts = createContacts(now);

    final ContactTileStyle contactTileStyle =
        Theme.of(context).extension<ContactTileStyle>()!;

    return SliverContainer(
      background: const ItemBox(),
      sliver: MultiSliver(
        children: [
          SliverFixedExtentList(
            itemExtent: contactTileStyle.height ?? 100,
            delegate: SliverChildBuilderDelegate(
              ((BuildContext context, int index) {
                final Profile contact = contacts[index];

                return ContactTile(
                  onTap: () => openChatPage(contact.id, contact.firstName),
                  firstName: contact.firstName,
                  lastName: contact.lastName,
                  lastSeen: contact.lastSeen,
                  now: now,
                );
              }),
              childCount: contacts.length,
            ),
          ),
          const SliverFillRemaining(
            hasScrollBody: false,
            child: SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}

extension on DateTime {
  DateTime copyWith(int hour, int minute) {
    return DateTime(year, month, day, hour - 12, minute);
  }
}

List<Profile> createContacts(DateTime time) => [
      Profile(firstName: 'Elizaveta', lastName: 'Aoki', lastSeen: time),
      Profile(firstName: 'Hari', lastSeen: time.copyWith(9, 24)),
      Profile(
          firstName: 'Alexandra',
          lastName: 'Sadler',
          lastSeen: time.copyWith(8, 15)),
      Profile(firstName: 'David', lastSeen: time.copyWith(8, 10)),
      Profile(
          firstName: 'Nikola',
          lastName: 'Jenkins',
          lastSeen: time.copyWith(7, 52)),
      Profile(
          firstName: 'Lukas',
          lastName: 'Nevena',
          lastSeen: time.copyWith(7, 45)),
      Profile(
          firstName: 'Josefin',
          lastName: 'Lovell',
          lastSeen: time.copyWith(4, 8)),
      Profile(firstName: 'Claudia', lastSeen: time.copyWith(1, 52)),
      Profile(
          firstName: 'Cayla',
          lastName: 'Barnes',
          lastSeen: time.copyWith(-9999, 0)),
    ];
