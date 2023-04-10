import 'package:equatable/equatable.dart';

class FirestoreChatParticipant extends Equatable {
  FirestoreChatParticipant({required this.id, required this.firstName});

  FirestoreChatParticipant.fromJson(Map<String, Object?> json)
      : this(
          id: json['id'] as String,
          firstName: json['first_name'] as String,
        );

  final String id;
  final String firstName;

  @override
  List<Object> get props => [id, firstName];

  Map<String, Object> toJson() => {'id': id, 'first_name': firstName};
}
