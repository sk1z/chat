import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:local_cache/local_cache.dart';

class FirestoreRepository {
  FirestoreRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance {
    _chatsRef = _firestore.collection('chats').withConverter<FirestoreChat>(
        fromFirestore: (snapshot, _) =>
            FirestoreChat.fromJson(snapshot.data()!),
        toFirestore: (chat, _) => chat.toJson());
    _profilesRef = _firestore.collection('profiles').withConverter<Profile>(
        fromFirestore: (snapshot, _) =>
            Profile.fromJson(snapshot.id, snapshot.data()!),
        toFirestore: (profile, _) => profile.toJson());
  }

  final FirebaseFirestore _firestore;
  late final CollectionReference<Profile> _profilesRef;
  late final CollectionReference<FirestoreChat> _chatsRef;

  String get userId => _userId;
  String _userId = '';

  Profile get currentProfile => _profile;
  Profile _profile = Profile.empty;

  Stream<Profile> profile(String userId) {
    _userId = userId;
    return _profilesRef.doc(userId).snapshots().map((snapshot) {
      try {
        _profile = snapshot.data()!;
        return _profile;
      } catch (_) {
        return Profile.empty;
      }
    });
  }

  Stream<CacheChats> cacheChats(DateTime? chatsLastFetch) {
    return _chatsRef
        .where('participant_ids', arrayContains: _userId)
        .where('last_updated', isGreaterThan: chatsLastFetch)
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) {
      final metaData = snapshot.metadata;
      final fromServer = !metaData.hasPendingWrites && !metaData.isFromCache;
      final chats = <CacheChat>[];
      for (final change in snapshot.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
          case DocumentChangeType.modified:
            final doc = change.doc;
            final chat = doc.data()!;
            final contact = chat.participants
                .firstWhere((participant) => participant.id != _userId);
            chats.add(CacheChat(
              userId: _userId,
              id: doc.id,
              contactId: contact.id,
              contactFirstName: contact.firstName,
              lastUpdated: chat.lastUpdated,
              lastCleared: chat.lastCleared,
              fromServer: fromServer,
            ));
            break;
          case DocumentChangeType.removed:
            break;
        }
      }
      return CacheChats(chats, fromServer);
    });
  }

  Stream<CacheMessages> cacheMessages(
      String chatId, DateTime? chatLastCleared, DateTime? lastFetchTime) {
    final messagesRef = _chatsRef
        .doc(chatId)
        .collection('messages')
        .withConverter<FirestoreMessage>(
            fromFirestore: (snapshot, _) =>
                FirestoreMessage.fromJson(snapshot.data()!),
            toFirestore: (message, _) => message.toJson());
    final Query<FirestoreMessage> query;
    if (chatLastCleared != null && lastFetchTime != null) {
      if (chatLastCleared.isAfter(lastFetchTime)) {
        query = messagesRef
            .where('sent_time', isGreaterThan: chatLastCleared)
            .orderBy('sent_time');
      } else {
        query = messagesRef
            .where('last_updated', isGreaterThan: lastFetchTime)
            .orderBy('last_updated')
            .orderBy('sent_time');
      }
    } else if (chatLastCleared != null) {
      query = messagesRef
          .where('sent_time', isGreaterThan: chatLastCleared)
          .orderBy('sent_time');
    } else if (lastFetchTime != null) {
      query = messagesRef
          .where('last_updated', isGreaterThan: lastFetchTime)
          .orderBy('last_updated')
          .orderBy('sent_time');
    } else {
      query = messagesRef.orderBy('sent_time');
    }

    return query.snapshots(includeMetadataChanges: true).map((snapshot) {
      final metaData = snapshot.metadata;
      final fromServer = !metaData.hasPendingWrites && !metaData.isFromCache;
      final messages = <CacheMessage>[];
      for (final change in snapshot.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
          case DocumentChangeType.modified:
            final doc = change.doc;
            final message = doc.data()!;
            messages.add(CacheMessage(
              userId: _userId,
              chat: chatId,
              id: doc.id,
              senderId: message.userId,
              message: message.deleted ? '' : message.message,
              sentTime: message.sentTime,
              lastUpdated: message.lastUpdated,
              deleted: message.deleted,
              fromServer: fromServer,
            ));
            break;
          case DocumentChangeType.removed:
            break;
        }
      }
      return CacheMessages(messages, fromServer);
    });
  }

  Future<void> clearChat(String chatId) async {
    final batch = _firestore.batch();
    final chatRef = _chatsRef.doc(chatId);
    final now = DateTime.now();
    batch.update(chatRef, {
      'last_updated': now,
      'last_cleared': now,
    });
    final snapshot = await chatRef.collection('messages').get();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    return batch.commit();
  }

  Future<void> addMessage({
    required bool chatExists,
    required String chatId,
    required String contactId,
    required String contactFirstName,
    required String message,
  }) async {
    final now = DateTime.now();
    if (!chatExists) {
      final chat = FirestoreChat(
        participants: [
          FirestoreChatParticipant(id: _userId, firstName: _profile.firstName),
          FirestoreChatParticipant(id: contactId, firstName: contactFirstName)
        ],
        lastUpdated: now,
      );
      await _chatsRef.doc(chatId).set(chat, SetOptions(merge: true));
    }
    await _chatsRef.doc(chatId).collection('messages').add(FirestoreMessage(
          userId: _userId,
          message: message,
          sentTime: now,
          lastUpdated: now,
        ).toJson());
  }

  Future<void> deleteMessage(String chatId, String messageId) {
    return _chatsRef.doc(chatId).collection('messages').doc(messageId).update({
      'last_updated': DateTime.now(),
      'deleted': true,
    });
  }

  Future<void> deleteMessages(String chatId, List<String> messageIds) {
    final now = DateTime.now();
    final messagesRef = _chatsRef.doc(chatId).collection('messages');
    final batch = _firestore.batch();
    for (final id in messageIds) {
      batch.update(messagesRef.doc(id), {
        'last_updated': now,
        'deleted': true,
      });
    }
    return batch.commit();
  }

  Future<void> createProfile(
      {required String firstName, String lastName = ''}) {
    return _profilesRef.doc(_userId).set(Profile(
          firstName: firstName,
          lastName: lastName,
        ));
  }

  Future<void> editName({String? firstName, String? lastName}) {
    return _profilesRef.doc(_userId).update({
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
    });
  }

  Stream<List<Profile>> allProfiles() {
    return _profilesRef
        .where(FieldPath.documentId, isNotEqualTo: _userId)
        .snapshots()
        .map((snapshot) {
      final profiles = snapshot.docs.map((doc) => doc.data()).toList();

      return profiles;
    });
  }

  Future<void> clearProfile() {
    return _profilesRef.doc(_userId).set(Profile.empty);
  }

  Future<void> addExampleMessages(
      String chatId, String userId, String contactId) async {
    final batch = _firestore.batch();
    final chatRef = _chatsRef.doc(chatId);
    final messagesRef = chatRef.collection('messages');
    final now = DateTime.now();
    batch.update(chatRef, {
      'last_updated': now,
      'last_cleared': now,
    });
    final snapshot = await messagesRef.get();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    batch.commit();
    final messages = _createExampleMessages(userId, contactId);
    for (final message in messages) {
      messagesRef.add(message.toJson());
    }
    for (int i = 0; i < 15; i++) {
      messagesRef.add(FirestoreMessage(
        userId: userId,
        message: '$i',
        sentTime: DateTime(2022, 11, 5, 12, i),
        lastUpdated: DateTime(2022, 11, 5, 12, i),
      ).toJson());
    }
    for (int i = 20; i < 30; i++) {
      messagesRef.add(FirestoreMessage(
        userId: contactId,
        message: '$i',
        sentTime: DateTime(2022, 11, 5, 15, i),
        lastUpdated: DateTime(2022, 11, 5, 15, i),
      ).toJson());
    }
    await Future.delayed(Duration(milliseconds: 300));
    _profilesRef.doc(_userId).set(Profile.empty);
    chatRef.update({
      'last_updated': now,
      'last_cleared': DateTime(2021),
    });
    await Future.delayed(Duration(milliseconds: 1000));
    _profilesRef.doc(_userId).set(Profile(firstName: 'skiz'));
  }
}

List<FirestoreMessage> _createExampleMessages(String userId, String contactId) {
  return [
    FirestoreMessage(
      userId: contactId,
      message: 'Hi',
      sentTime: DateTime(2022, 11, 5, 13, 1),
      lastUpdated: DateTime(2022, 11, 5, 13, 1),
    ),
    FirestoreMessage(
      userId: contactId,
      message: 'Helloooo?',
      sentTime: DateTime(2022, 11, 5, 13, 2),
      lastUpdated: DateTime(2022, 11, 5, 13, 2),
    ),
    FirestoreMessage(
      userId: userId,
      message: 'Hi James',
      sentTime: DateTime(2022, 11, 5, 13, 5),
      lastUpdated: DateTime(2022, 11, 5, 13, 5),
    ),
    FirestoreMessage(
      userId: contactId,
      message: 'Do you want to watch the basketball game tonight?'
          ' We could order some chinese food :)',
      sentTime: DateTime(2022, 11, 5, 13, 7),
      lastUpdated: DateTime(2022, 11, 5, 13, 7),
    ),
    FirestoreMessage(
      userId: userId,
      message: 'Sounds great! Let us meet at 7 PM, okay?',
      sentTime: DateTime(2022, 11, 5, 13, 7, 15),
      lastUpdated: DateTime(2022, 11, 5, 13, 7, 15),
    ),
    FirestoreMessage(
      userId: contactId,
      message: 'See you later!',
      sentTime: DateTime(2022, 11, 5, 13, 9),
      lastUpdated: DateTime(2022, 11, 5, 13, 9),
    ),
  ];
}
