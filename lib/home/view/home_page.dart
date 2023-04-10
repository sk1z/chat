import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/app/app.dart';
import 'package:flutter_firebase_login/item_tile/item_tile.dart';
import 'package:flutter_firebase_login/chats/chats.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.userSlash),
            onPressed: () {
              context.read<AppBloc>().add(ClearProfile());
            },
            iconSize: 19,
          ),
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AppBloc>().add(AppLogoutRequested());
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: SizedBox.shrink()),
            ItemTile(
              icon: Icon(FontAwesomeIcons.solidUser, size: 19.5),
              title: 'Contacts',
              onTap: () {
                Navigator.pop(context);
                context.go('/contacts');
              },
            ),
            ItemTile(
              icon: Icon(FontAwesomeIcons.gear, size: 23.5),
              title: 'Settings',
              onTap: () {
                Navigator.pop(context);
                context.go('/settings');
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<ChatsCubit, ChatsState>(
        buildWhen: (ChatsState previous, ChatsState current) =>
            previous.chats != current.chats,
        builder: (BuildContext context, ChatsState state) {
          return ChatList(
            chats: state.chatList,
          );
        },
      ),
    );
  }
}
