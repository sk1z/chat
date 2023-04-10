import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/app/app.dart';
import 'package:flutter_firebase_login/chat/chat.dart';
import 'package:flutter_firebase_login/chats/cubit/chats_cubit.dart';
import 'package:flutter_firebase_login/contacts/contacts.dart';
import 'package:flutter_firebase_login/email_update/email_update.dart';
import 'package:flutter_firebase_login/home/home.dart';
import 'package:flutter_firebase_login/login/login.dart';
import 'package:flutter_firebase_login/name_edit/name_edit.dart';
import 'package:flutter_firebase_login/password_update/password_update.dart';
import 'package:flutter_firebase_login/profile_creation/profile_creation.dart';
import 'package:flutter_firebase_login/settings/settings.dart';
import 'package:flutter_firebase_login/sign_up/sign_up.dart';
import 'package:flutter_firebase_login/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:local_cache/local_cache.dart';

class App extends StatelessWidget {
  App({
    required this.authenticationRepository,
    required this.localCache,
    required this.firestoreRepository,
  }) : _appBloc = AppBloc(
            authenticationRepository: authenticationRepository,
            firestoreRepository: firestoreRepository);

  final AuthenticationRepository authenticationRepository;
  final LocalCacheClient localCache;
  final FirestoreRepository firestoreRepository;

  final AppBloc _appBloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: localCache),
        RepositoryProvider.value(value: firestoreRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _appBloc),
          BlocProvider(
              create: (_) => ChatsCubit(
                  localCache: localCache,
                  firestoreRepository: firestoreRepository)),
        ],
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
      GoRoute(
        path: '/',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return SlideWithFadeTransitionPage(
            key: state.pageKey,
            child: const HomePage(),
          );
        },
        routes: [
          GoRoute(
            path: 'chats/:contact_id',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return SlideWithFadeTransitionPage(
                key: state.pageKey,
                child: ChatFlow(
                  contactId: state.params['contact_id']!,
                  contactFirstName: state.queryParams['contact_first_name']!,
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

  static final CurveTween _tween = CurveTween(curve: Curves.ease);
  static final Animatable<Offset> _position = Tween<Offset>(
    begin: const Offset(0.2, 0),
    end: Offset.zero,
  ).chain(_tween);

  @override
  Route<void> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionDuration: const Duration(milliseconds: 170),
      reverseTransitionDuration: const Duration(milliseconds: 170),
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SlideTransition(
          position: _position.animate(animation),
          child: FadeTransition(
            opacity: _tween.animate(animation),
            child: child,
          ),
        );
      },
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
