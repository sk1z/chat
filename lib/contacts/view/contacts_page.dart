import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/item_box/item_box.dart';
import 'package:chat/item_divider/item_divider.dart';
import 'package:chat/item_tile/item_tile.dart';
import 'package:chat/contacts/contacts.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              ItemBox(
                child: Column(children: [
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
                ]),
              ),
              const ItemDivider(title: 'Sorted by last seen time'),
            ]),
          ),
          BlocProvider(
            create: (_) => ContactsCubit(
                firestoreRepository: context.read<FirestoreRepository>()),
            child: BlocBuilder<ContactsCubit, ContactsState>(
              buildWhen: (ContactsState previous, ContactsState current) =>
                  previous.contacts != current.contacts,
              builder: (BuildContext context, ContactsState state) {
                return ContactList(
                  contacts: state.contacts,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
