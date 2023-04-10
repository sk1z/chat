part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  emptyProfile,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
    this.profile = Profile.empty,
  });

  const AppState.authenticated(
    User user,
    Profile firestoreUser,
  ) : this._(
          status: AppStatus.authenticated,
          user: user,
          profile: firestoreUser,
        );

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.withoutPersonalData(User user)
      : this._(
          status: AppStatus.emptyProfile,
          user: user,
        );

  AppState copyWtih({
    User? user,
    Profile? profile,
  }) =>
      AppState._(
        status: AppStatus.authenticated,
        user: user ?? this.user,
        profile: profile ?? this.profile,
      );

  final AppStatus status;
  final User user;
  final Profile profile;

  @override
  List<Object> get props => [status, user, profile];
}
