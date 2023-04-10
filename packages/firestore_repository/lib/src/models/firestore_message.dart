import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FirestoreMessage extends Equatable {
  const FirestoreMessage({
    required this.userId,
    required this.message,
    required this.sentTime,
    required this.lastUpdated,
    bool? deleted,
  }) : deleted = deleted ?? false;

  FirestoreMessage.fromJson(Map<String, Object?> json)
      : this(
          userId: json['user_id'] as String,
          message: json['message'] as String,
          sentTime: (json['sent_time'] as Timestamp).toDate(),
          lastUpdated: (json['last_updated'] as Timestamp).toDate(),
          deleted: json['deleted'] != null ? json['deleted'] as bool : null,
        );

  final String userId;
  final String message;
  final DateTime sentTime;
  final DateTime lastUpdated;
  final bool deleted;

  @override
  List<Object> get props => [userId, message, sentTime, lastUpdated, deleted];

  Map<String, Object> toJson() => {
        'user_id': userId,
        'message': message,
        'sent_time': sentTime,
        'last_updated': lastUpdated,
        if (deleted) 'deleted': deleted,
      };
}
