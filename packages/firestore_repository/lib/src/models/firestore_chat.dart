import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_chat_participant.dart';

class FirestoreChat extends Equatable {
  const FirestoreChat({
    required this.participants,
    required this.lastUpdated,
    this.lastCleared,
  });

  FirestoreChat.fromJson(Map<String, Object?> json)
      : this(
          participants: (json['participants'] as List<dynamic>)
              .map((map) => FirestoreChatParticipant.fromJson(map))
              .toList(),
          lastUpdated: (json['last_updated'] as Timestamp).toDate(),
          lastCleared: json['last_cleared'] != null
              ? (json['last_cleared'] as Timestamp).toDate()
              : null,
        );

  final List<FirestoreChatParticipant> participants;
  final DateTime lastUpdated;
  final DateTime? lastCleared;

  @override
  List<Object?> get props => [lastUpdated, lastCleared];

  Map<String, Object> toJson() => {
        'participant_ids':
            participants.map((participant) => participant.id).toList(),
        'participants':
            participants.map((participant) => participant.toJson()).toList(),
        'last_updated': lastUpdated,
        if (lastCleared != null) 'last_cleared': lastCleared!
      };
}
