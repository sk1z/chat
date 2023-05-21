import 'package:drift/drift.dart';

class CacheMessages extends Table with CacheItem {
  TextColumn get chat => text()();
  TextColumn get senderId => text()();
  TextColumn get message => text()();
  DateTimeColumn get sentTime => dateTime()();
  DateTimeColumn get lastUpdated => dateTime()();
  BoolColumn get deleted => boolean()();

  @override
  Set<Column> get primaryKey => {userId, id, chat};

  @override
  List<String> get customConstraints =>
      ['FOREIGN KEY (user_id, chat) REFERENCES cache_chats (user_id, id)'];
}

class CacheChats extends Table with CacheItem {
  TextColumn get contactId => text()();
  TextColumn get contactFirstName => text()();
  DateTimeColumn get lastUpdated => dateTime()();
  DateTimeColumn get lastCleared => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {userId, id};
}

mixin CacheItem on Table {
  TextColumn get userId => text()();
  TextColumn get id => text()();
  BoolColumn get fromServer => boolean()();
}
