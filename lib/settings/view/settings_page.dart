import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/app/app.dart';
import 'package:chat/header/header.dart';
import 'package:chat/item_divider/item_divider.dart';
import 'package:chat/item_tile/item_tile.dart';
import 'package:chat/item_box/item_box.dart';
import 'package:chat/profile_edit_menu/profile_edit_menu.dart';
import 'package:chat/settings/settings.dart';
import 'package:chat/styles/flexible_profile_tile_style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FlexibleProfileTileStyle flexibleProfileTileStyle =
        Theme.of(context).extension<FlexibleProfileTileStyle>()!;

    return BlocProvider(
      create: (_) => SettingsCubit(
          authenticationRepository: context.read<AuthenticationRepository>()),
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (BuildContext context, SettingsState state) {
          if (state.passwordRemoveStatus.isFailure ||
              state.googleUpdateStatus.isFailure) {
            Fluttertoast.cancel();
            Fluttertoast.showToast(
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              msg: state.errorMessage ??
                  () {
                    if (state.passwordRemoveStatus.isFailure) {
                      return 'Password Remove Failure';
                    } else {
                      return 'Google Account Update Failure';
                    }
                  }(),
            );
          }
        },
        child: Scaffold(
          body: CustomScrollView(slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              expandedHeight: flexibleProfileTileStyle.expandedHeight,
              flexibleSpace: BlocBuilder<AppBloc, AppState>(
                buildWhen: (AppState previous, AppState current) =>
                    previous.profile != current.profile,
                builder: (BuildContext context, AppState state) {
                  return FlexibleProfileTile(
                    firstName: state.profile.firstName,
                    lastName: state.profile.lastName,
                  );
                },
              ),
              actions: [
                ProfileEditMenuButton(
                  itemBuilder: () => [
                    ProfileEditMenuItem(
                      onTap: () => context.go('/settings/name_edit'),
                      icon: const Icon(Icons.edit),
                      title: 'Edit name',
                    ),
                    ProfileEditMenuItem(
                      onTap: () {},
                      icon: const Icon(Icons.add_a_photo),
                      title: 'Set Profile Photo',
                    ),
                    ProfileEditMenuItem(
                      onTap: () =>
                          context.read<AppBloc>().add(AppLogoutRequested()),
                      icon: const Icon(Icons.logout_rounded),
                      title: 'Log Out',
                    ),
                  ],
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                ItemBox(
                  child: ItemTile(
                    onTap: () {},
                    mode: ItemTileMode.accent,
                    icon: const Icon(Icons.add_a_photo),
                    title: 'Set Profile Photo',
                  ),
                ),
                const ItemDivider(),
                const ItemBox(
                  child: Column(children: [
                    Header(title: 'Account'),
                    _EmailUpdateTile(),
                    _GoogleUpdateTile(),
                    _PasswordUpdateTile(),
                  ]),
                ),
                const ItemDivider(),
                const ItemBox(child: _PasswordRemoveTile()),
                const SizedBox(height: 500),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class _EmailUpdateTile extends StatelessWidget {
  const _EmailUpdateTile();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (AppState previous, AppState current) =>
          previous.user.email != current.user.email,
      builder: (BuildContext context, AppState state) {
        return ItemTile(
          onTap: () => context.go('/settings/email_update'),
          // title: '+7 (917) 105-53-78',
          title: state.user.email ?? 'None',
          // subtitle: 'Tap to change phone number',
          subtitle: 'Tap to change email',
          divider: true,
        );
      },
    );
  }
}

class _GoogleUpdateTile extends StatelessWidget {
  const _GoogleUpdateTile();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (AppState previous, AppState current) =>
          previous.user.googleProvider != current.user.googleProvider,
      builder: (BuildContext context, AppState state) {
        return ItemTile(
          onTap: () => context.read<SettingsCubit>().updateGoogle(),
          // title: 'None',
          // title: 'some@mail.com',
          title: state.user.googleProvider?.email ?? 'Link google account',
          // subtitle: 'Username',
          subtitle: state.user.googleProvider != null
              ? 'Tap to unlink google account'
              : null,
          divider: true,
        );
      },
    );
  }
}

class _PasswordUpdateTile extends StatelessWidget {
  const _PasswordUpdateTile();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
        buildWhen: (AppState previous, AppState current) =>
            previous.user.passwordProvider != current.user.passwordProvider,
        builder: (BuildContext context, AppState state) {
          return ItemTile(
            onTap: () => context.go('/settings/password_update'),
            // title: 'Bio',
            title: state.user.passwordProvider == null
                ? 'Set a password'
                : 'Update password',
            // subtitle: 'Add a few words about yourself',
          );
        });
  }
}

class _PasswordRemoveTile extends StatelessWidget {
  const _PasswordRemoveTile();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (AppState previous, AppState current) =>
          previous.user.passwordProvider != current.user.passwordProvider,
      builder: (BuildContext context, AppState state) {
        if (state.user.passwordProvider == null) {
          return const SizedBox.shrink();
        }

        return ItemTile(
          onTap: () => context.read<SettingsCubit>().removePassword(),
          title: 'Remove password',
        );
      },
    );
  }
}
