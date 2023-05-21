import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/app/app.dart';
import 'package:chat/chat/chat.dart';
import 'package:chat/chats/cubit/chats_cubit.dart';
import 'package:chat/contacts/contacts.dart';
import 'package:chat/email_update/email_update.dart';
import 'package:chat/home/home.dart';
import 'package:chat/login/login.dart';
import 'package:chat/name_edit/name_edit.dart';
import 'package:chat/password_update/password_update.dart';
import 'package:chat/profile_creation/profile_creation.dart';
import 'package:chat/settings/settings.dart';
import 'package:chat/sign_up/sign_up.dart';
import 'package:chat/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:local_cache/local_cache.dart';

class App extends StatelessWidget {
  App({
    required this.authenticationRepository,
    required this.firestoreRepository,
    required this.localCache,
  }) : _appBloc = AppBloc(
            authenticationRepository: authenticationRepository,
            firestoreRepository: firestoreRepository);

  final AuthenticationRepository authenticationRepository;
  final FirestoreRepository firestoreRepository;
  final LocalCacheClient localCache;

  final AppBloc _appBloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: firestoreRepository),
        RepositoryProvider.value(value: localCache),
      ],
      child: BlocProvider.value(
        value: _appBloc,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: theme,
          routerConfig: _router,
        ),
      ),
    );
  }

  late final _AppStateRefreshStream _appState =
      _AppStateRefreshStream(_appBloc);

  late final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return SlideWithFadeTransitionPage(
            key: state.pageKey,
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        path: '/sign_up',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return SlideWithFadeTransitionPage(
            key: state.pageKey,
            child: const SignUpPage(),
          );
        },
      ),
      GoRoute(
        path: '/profile_creation',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return SlideWithFadeTransitionPage(
            key: state.pageKey,
            child: const ProfileCreationPage(),
          );
        },
      ),
      ShellRoute(
        pageBuilder: (BuildContext context, GoRouterState state, Widget child) {
          return SlideWithFadeTransitionPage(
            key: state.pageKey,
            child: BlocProvider(
              create: (_) => ChatsCubit(
                  localCache: context.read<LocalCacheClient>(),
                  firestoreRepository: firestoreRepository),
              child: child,
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
            routes: [
              GoRoute(
                path: 'chats/:contact_id',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return SlideWithFadeTransitionPage(
                    key: state.pageKey,
                    child: ChatFlow(
                      contactId: state.params['contact_id']!,
                      contactFirstName:
                          state.queryParams['contact_first_name']!,
                    ),
                  );
                },
              ),
              GoRoute(
                path: 'contacts',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return SlideWithFadeTransitionPage(
                    key: state.pageKey,
                    child: const ContactsPage(),
                  );
                },
              ),
              GoRoute(
                path: 'settings',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return SlideWithFadeTransitionPage(
                    key: state.pageKey,
                    child: const SettingsPage(),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'email_update',
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      return SlideWithFadeTransitionPage(
                        key: state.pageKey,
                        child: const EmailUpdateFlow(),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'password_update',
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      return SlideWithFadeTransitionPage(
                        key: state.pageKey,
                        child: const PasswordUpdateFlow(),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'name_edit',
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      return SlideWithFadeTransitionPage(
                        key: state.pageKey,
                        child: const NameEditPage(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: _guard,
    refreshListenable: _appState,
  );

  String? _guard(BuildContext context, GoRouterState state) {
    switch (_appState.status) {
      case AppStatus.unauthenticated:
        if (state.subloc != '/login' && state.subloc != '/sign_up') {
          return '/login';
        }
        break;
      case AppStatus.emptyProfile:
        if (state.subloc != '/profile_creation') {
          return '/profile_creation';
        }
        break;
      case AppStatus.authenticated:
        if (state.subloc == '/login' ||
            state.subloc == '/sign_up' ||
            state.subloc == '/profile_creation') {
          return '/';
        }
        break;
    }

    return null;
  }
}

class SlideWithFadeTransitionPage extends Page<void> {
  const SlideWithFadeTransitionPage({super.key, required this.child});

  final Widget child;

  @override
  Route<void> createRoute(BuildContext context) {
    return _PageBasedMaterialPageRoute(page: this, child: child);
  }
}

class _PageBasedMaterialPageRoute<T> extends PageRoute<T> {
  _PageBasedMaterialPageRoute(
      {required SlideWithFadeTransitionPage page, required this.child})
      : super(settings: page);

  final Widget child;

  SlideWithFadeTransitionPage get _page =>
      settings as SlideWithFadeTransitionPage;

  static final CurveTween _easeTween = CurveTween(curve: Curves.ease);
  static final Animatable<Offset> _positionTween = Tween<Offset>(
    begin: const Offset(0.2, 0),
    end: Offset.zero,
  ).chain(_easeTween);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 170);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 170);

  @override
  Widget buildPage(_, __, ___) {
    return _page.child;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: animation.drive(_positionTween),
      child: FadeTransition(
        opacity: animation.drive(_easeTween),
        child: child,
      ),
    );
  }
}

class _AppStateRefreshStream extends ChangeNotifier {
  _AppStateRefreshStream(AppBloc bloc) : _status = bloc.state.status {
    _subscription = bloc.stream.asBroadcastStream().listen((state) {
      if (state.status != _status) {
        _status = state.status;
        notifyListeners();
      }
    });
  }

  late final StreamSubscription<AppState> _subscription;

  AppStatus _status;
  AppStatus get status => _status;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
