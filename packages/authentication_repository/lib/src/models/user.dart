import 'package:equatable/equatable.dart';

import 'provider.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.googleProvider,
    this.passwordProvider,
  });

  final String id;

  final String? email;

  final String? name;

  final String? photo;

  final Provider? googleProvider;

  final Provider? passwordProvider;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props =>
      [id, email, name, photo, googleProvider, passwordProvider];
}
