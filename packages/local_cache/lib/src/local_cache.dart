import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables.dart';

part 'local_cache.g.dart';

@DriftDatabase(tables: [CacheMessages, CacheChats])
class LocalCacheClient extends _$LocalCacheClient {
  LocalCacheClient() : super(_openConnection());

  String userId = '';

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    });
  }

  Future<DateTime?> chatsLastFetchTime() async {
    final otherChats = alias(cacheChats, 'other_chats');
    final chat = await (select(cacheChats)
          ..where((t) {
            return t.userId.equals(userId) &
                t.fromServer &
                notExistsQuery(select(otherChats)
                  ..where((tbl) {
                    return tbl.userId.equals(userId) &
                        tbl.fromServer &
                        (tbl.lastUpdated.isBiggerThan(t.lastUpdated) |
                            tbl.lastUpdated.equalsExp(t.lastUpdated) &
                                tbl.id.isBiggerThan(t.id));
                  }));
          }))
        .getSingleOrNull();
    return chat?.lastUpdated;
  }

  Future<Map<String, DateTime?>> messagesLastFetchTimes() async {
    final otherMessages = alias(cacheMessages, 'other_messages');
    final query = select(cacheMessages)
      ..where((t) {
        return t.userId.equals(userId) &
            t.fromServer &
            notExistsQuery(select(otherMessages)
              ..where((tbl) {
                return tbl.chat.equalsExp(t.chat) &
                    tbl.userId.equals(userId) &
                    tbl.fromServer &
                    (tbl.lastUpdated.isBiggerThan(t.lastUpdated) |
                        tbl.lastUpdated.equalsExp(t.lastUpdated) &
                            tbl.id.isBiggerThan(t.id));
              }));
      });
    final messages = await query.get();
    return {for (final message in messages) message.chat: message.lastUpdated};
  }

  Future<void> insertMessages(
      String chatId, List<CacheMessage> messages, bool fromServer) {
    return batch((batch) {
      if (fromServer) {
        batch.update(
          cacheMessages,
          CacheMessagesCompanion(
            fromServer: Value(true),
          ),
          where: ($CacheMessagesTable t) {
            return t.chat.equals(chatId) &
                t.userId.equals(userId) &
                t.fromServer.not();
          },
        );
      }
      if (messages.isNotEmpty) {
        batch.insertAllOnConflictUpdate(cacheMessages, messages);
        batch.deleteWhere(cacheMessages, ($CacheMessagesTable t) {
          return t.userId.equals(userId) &
              existsQuery(select(cacheChats)
                ..where((tbl) {
                  return tbl.id.equalsExp(t.chat) &
                      tbl.userId.equals(userId) &
                      tbl.lastCleared.isBiggerOrEqual(t.sentTime);
                }));
        });
      }
    });
  }

  Stream<List<CacheMessage>> watchMessages(String chatId) {
    return (select(cacheMessages)
          ..where((t) {
            return t.chat.equals(chatId) &
                t.userId.equals(userId) &
                t.deleted.not();
          })
          ..orderBy([(t) => OrderingTerm(expression: t.sentTime)]))
        .watch();
  }

  Future<void> insertChats(List<CacheChat> chats, bool fromServer) {
    return batch((batch) {
      if (fromServer) {
        batch.update(
          cacheChats,
          CacheChatsCompanion(
            fromServer: Value(true),
          ),
          where: ($CacheChatsTable t) {
            return t.userId.equals(userId) & t.fromServer.not();
          },
        );
      }
      batch.insertAllOnConflictUpdate(cacheChats, chats);
      final chatIds = chats.map((chat) => chat.id);
      batch.deleteWhere(cacheMessages, ($CacheMessagesTable t) {
        return t.chat.isIn(chatIds) &
            t.userId.equals(userId) &
            existsQuery(select(cacheChats)
              ..where((tbl) {
                return tbl.id.equalsExp(t.chat) &
                    tbl.userId.equals(userId) &
                    t.sentTime.isSmallerOrEqual(tbl.lastCleared);
              }));
      });
    });
  }

  Stream<List<ChatWithLastMessage>> watchChats() {
    final otherMessages = alias(cacheMessages, 'other_messages');
    final query = (select(cacheChats)
          ..where((t) {
            return t.userId.equals(userId);
          }))
        .join([
      leftOuterJoin(
        cacheMessages,
        cacheMessages.chat.equalsExp(cacheChats.id) &
            cacheMessages.userId.equals(userId) &
            cacheMessages.deleted.not() &
            notExistsQuery(select(otherMessages)
              ..where((t) {
                return t.chat.equalsExp(cacheMessages.chat) &
                    t.userId.equals(userId) &
                    t.deleted.not() &
                    (t.sentTime.isBiggerThan(cacheMessages.sentTime) |
                        t.sentTime.equalsExp(cacheMessages.sentTime) &
                            t.id.isBiggerThan(cacheMessages.id));
              })),
      ),
    ]);
    query.orderBy([OrderingTerm.desc(cacheMessages.sentTime)]);
    return query.map((row) {
      final chat = row.readTable(cacheChats);
      final message = row.readTableOrNull(cacheMessages);
      return ChatWithLastMessage(
        id: chat.id,
        contactId: chat.contactId,
        contactFirstName: chat.contactFirstName,
        messageUid: message?.userId,
        message: message?.message,
        messageSentTime: message?.sentTime,
        lastCleared: chat.lastCleared,
      );
    }).watch();
  }
}

class ChatWithLastMessage {
  ChatWithLastMessage({
    required this.id,
    required this.contactId,
    required this.contactFirstName,
    this.messageUid,
    this.message,
    this.messageSentTime,
    this.lastCleared,
  });

  final String id;
  final String contactId;
  final String contactFirstName;
  final String? messageUid;
  final String? message;
  final DateTime? messageSentTime;
  final DateTime? lastCleared;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
