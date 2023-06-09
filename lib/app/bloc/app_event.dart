part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppUserChanged extends AppEvent {
  @visibleForTesting
  const AppUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class AppLogoutRequested extends AppEvent {}

class AppProfileChanged extends AppEvent {
  const AppProfileChanged(this.profile);

  final Profile profile;

  @override
  List<Object> get props => [profile];
}

class ClearProfile extends AppEvent {}
