import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/item_divider/item_divider.dart';
import 'package:flutter_firebase_login/item_tile/item_tile.dart';
import 'package:flutter_firebase_login/contact/contact.dart';
import 'package:flutter_firebase_login/contacts/contacts.dart';
import 'package:go_router/go_router.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    void openChatPage(String contactId, String contactFirstName) {
      context.go('/chats/${contactId}?contact_first_name=${contactFirstName}');
    }

    final DateTime now = DateTime.now();

    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              ItemTile(
                onTap: () {},
                icon: const Icon(Icons.perm_contact_cal_rounded),
                title: 'Invite Friends',
              ),
              ItemTile(
                onTap: () {},
                icon: const Icon(Icons.location_on_outlined),
                title: 'Find People Nearby',
              ),
              const ItemDivider(title: 'Sorted by last seen time'),
            ]),
          ),
          BlocProvider(
            create: (_) => ContactsCubit(
                firestoreRepository: context.read<FirestoreRepository>()),
            child: BlocBuilder<ContactsCubit, ContactsState>(
              builder: (BuildContext context, ContactsState state) {
                final List<Profile> contacts = state.contacts;

                // final List<Profile> contacts = createContacts(now);

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    ((BuildContext context, int index) {
                      final Profile contact = contacts[index];

                      return ContactTile(
                        onTap: () =>
                            openChatPage(contact.id, contact.firstName),
                        firstName: contact.firstName,
                        lastName: contact.lastName,
                        lastSeen: contact.lastSeen,
                        now: now,
                      );
                    }),
                    childCount: contacts.length,
                  ),
                );
              },
            ),
          ),
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
      Profile(firstName: 'Андрей', lastName: 'Ижуткин', lastSeen: time),
      Profile(firstName: 'Кладка', lastSeen: time.copyWith(9, 24)),
      Profile(firstName: 'Маргарита', lastSeen: time.copyWith(8, 15)),
      Profile(firstName: 'Мама', lastSeen: time.copyWith(8, 10)),
      Profile(
          firstName: 'Nati',
          lastName: 'Samoylova',
          lastSeen: time.copyWith(7, 52)),
      Profile(
          firstName: 'Чел Из',
          lastName: 'Сгэу',
          lastSeen: time.copyWith(7, 45)),
      Profile(firstName: 'Тимофеев', lastSeen: time.copyWith(4, 8)),
      Profile(firstName: 'sk1z', lastSeen: time.copyWith(1, 52)),
      Profile(
          firstName: 'Вадим',
          lastName: 'Сечкин',
          lastSeen: time.copyWith(-9999, 0)),
    ];
