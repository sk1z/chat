import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  const Profile({
    this.id = '',
    required this.firstName,
    this.lastName = '',
    this.lastSeen,
  });

  Profile.fromJson(String id, Map<String, Object?> json)
      : this(
          id: id,
          firstName: json['first_name'] as String,
          lastName: json['last_name'] as String,
        );

  final String id;
  final String firstName;
  final String lastName;
  final DateTime? lastSeen;

  static const empty = Profile(firstName: '');

  bool get isEmpty => this == Profile.empty;

  bool get isNotEmpty => this != Profile.empty;

  @override
  List<Object?> get props => [firstName, lastName, lastSeen];

  Map<String, Object> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
      };
}
