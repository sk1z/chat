import 'package:drift/drift.dart';

class CacheMessages extends Table with CacheItem {
  TextColumn get chat => text().references(CacheChats, #id)();
  TextColumn get userId => text()();
  TextColumn get message => text()();
  DateTimeColumn get sentTime => dateTime()();
  DateTimeColumn get lastUpdated => dateTime()();
  BoolColumn get deleted => boolean()();

  @override
  Set<Column> get primaryKey => {id, chat};
}

class CacheChats extends Table with CacheItem {
  TextColumn get contactId => text()();
  TextColumn get contactFirstName => text()();
  DateTimeColumn get lastUpdated => dateTime()();
  DateTimeColumn get lastCleared => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

mixin CacheItem on Table {
  TextColumn get id => text()();
  BoolColumn get fromServer => boolean()();
}
