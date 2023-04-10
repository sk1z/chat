import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/app/app.dart';
import 'package:flutter_firebase_login/header/header.dart';
import 'package:flutter_firebase_login/item_divider/item_divider.dart';
import 'package:flutter_firebase_login/item_tile/item_tile.dart';
import 'package:flutter_firebase_login/item_box/item_box.dart';
import 'package:flutter_firebase_login/profile_edit_menu/profile_edit_menu.dart';
import 'package:flutter_firebase_login/settings/settings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // SettingsAppBarStyle
    final double expandedHeight = 144.0;

    return BlocProvider(
      create: (_) => SettingsCubit(
          authenticationRepository: context.read<AuthenticationRepository>()),
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (BuildContext context, SettingsState state) {
          if (state.passwordRemoveStatus.isSubmissionFailure ||
              state.googleUpdateStatus.isSubmissionFailure) {
            Fluttertoast.cancel();
            Fluttertoast.showToast(
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              msg: state.errorMessage ??
                  () {
                    if (state.passwordRemoveStatus.isSubmissionFailure) {
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
              expandedHeight: expandedHeight,
              flexibleSpace: BlocBuilder<AppBloc, AppState>(
                buildWhen: (AppState previous, AppState current) =>
                    previous.profile != current.profile,
                builder: (BuildContext context, AppState state) {
                  return FlexibleProfileTile(
                    expandedHeight: expandedHeight,
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
                ItemBox(
                  child: Column(children: [
                    const Header(title: 'Account'),
                    const _EmailUpdateTile(),
                    const _GoogleUpdateTile(),
                    const _PasswordUpdateTile(),
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
          // title: '+7 (917) 955-53-28',
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
          // title: 'skiz1488@gmail.com',
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
          return SizedBox.shrink();
        }

        return ItemTile(
          onTap: () => context.read<SettingsCubit>().removePassword(),
          title: 'Remove password',
        );
      },
    );
  }
}
