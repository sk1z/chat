import 'package:equatable/equatable.dart';

class Provider extends Equatable {
  const Provider({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.name,
    required this.photo,
  });

  final String? id;
  final String? email;
  final String? phoneNumber;
  final String? name;
  final String? photo;

  @override
  List<Object?> get props => [
        id,
        email,
        phoneNumber,
        name,
        photo,
      ];
}
