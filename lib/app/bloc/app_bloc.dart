import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationRepository authenticationRepository,
    required FirestoreRepository firestoreRepository,
  })  : _authRepository = authenticationRepository,
        _firestoreRepository = firestoreRepository,
        super(authenticationRepository.currentUser.isEmpty
            ? const AppState.unauthenticated()
            : firestoreRepository.currentProfile.isEmpty
                ? AppState.withoutPersonalData(
                    authenticationRepository.currentUser)
                : AppState.authenticated(
                    authenticationRepository.currentUser,
                    firestoreRepository.currentProfile,
                  )) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<AppProfileChanged>(_onProfileChanged);
    on<ClearProfile>(_clearProfile);

    _userSubscription =
        _authRepository.user.listen((user) => add(AppUserChanged(user)));
    final user = _authRepository.currentUser;
    if (user.isNotEmpty) {
      _profileSubscription = _firestoreRepository
          .profile(user.id)
          .listen((profile) => add(AppProfileChanged(profile)));
    }
  }

  final AuthenticationRepository _authRepository;
  late final StreamSubscription<User> _userSubscription;
  final FirestoreRepository _firestoreRepository;
  StreamSubscription<Profile>? _profileSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) async {
    final user = event.user;

    if (user.isEmpty) {
      emit(const AppState.unauthenticated());
      _profileSubscription?.cancel();
    } else if (user.id != state.user.id) {
      final profile = await _firestoreRepository.profile(user.id).first;

      if (profile.isNotEmpty) {
        emit(state.copyWtih(user: user, profile: profile));
      } else {
        emit(AppState.withoutPersonalData(user));
      }

      _profileSubscription?.cancel();
      _profileSubscription =
          _firestoreRepository.profile(user.id).listen((profile) {
        add(AppProfileChanged(profile));
      });
    } else {
      if (state.profile.isNotEmpty) {
        emit(state.copyWtih(user: user));
      } else {
        emit(AppState.withoutPersonalData(user));
      }
    }
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authRepository.logOut());
  }

  void _onProfileChanged(AppProfileChanged event, Emitter<AppState> emit) {
    final profile = event.profile;

    emit(profile.isNotEmpty
        ? state.copyWtih(profile: profile)
        : AppState.withoutPersonalData(state.user));
  }

  void _clearProfile(ClearProfile event, Emitter<AppState> emit) {
    _firestoreRepository.clearProfile();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _profileSubscription?.cancel();
    return super.close();
  }
}
