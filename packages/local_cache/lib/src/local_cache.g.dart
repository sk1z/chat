// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_cache.dart';

// ignore_for_file: type=lint
class CacheChat extends DataClass implements Insertable<CacheChat> {
  final String id;
  final bool fromServer;
  final String contactId;
  final String contactFirstName;
  final DateTime lastUpdated;
  final DateTime? lastCleared;
  const CacheChat(
      {required this.id,
      required this.fromServer,
      required this.contactId,
      required this.contactFirstName,
      required this.lastUpdated,
      this.lastCleared});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['from_server'] = Variable<bool>(fromServer);
    map['contact_id'] = Variable<String>(contactId);
    map['contact_first_name'] = Variable<String>(contactFirstName);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    if (!nullToAbsent || lastCleared != null) {
      map['last_cleared'] = Variable<DateTime>(lastCleared);
    }
    return map;
  }

  CacheChatsCompanion toCompanion(bool nullToAbsent) {
    return CacheChatsCompanion(
      id: Value(id),
      fromServer: Value(fromServer),
      contactId: Value(contactId),
      contactFirstName: Value(contactFirstName),
      lastUpdated: Value(lastUpdated),
      lastCleared: lastCleared == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCleared),
    );
  }

  factory CacheChat.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CacheChat(
      id: serializer.fromJson<String>(json['id']),
      fromServer: serializer.fromJson<bool>(json['fromServer']),
      contactId: serializer.fromJson<String>(json['contactId']),
      contactFirstName: serializer.fromJson<String>(json['contactFirstName']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
      lastCleared: serializer.fromJson<DateTime?>(json['lastCleared']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fromServer': serializer.toJson<bool>(fromServer),
      'contactId': serializer.toJson<String>(contactId),
      'contactFirstName': serializer.toJson<String>(contactFirstName),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'lastCleared': serializer.toJson<DateTime?>(lastCleared),
    };
  }

  CacheChat copyWith(
          {String? id,
          bool? fromServer,
          String? contactId,
          String? contactFirstName,
          DateTime? lastUpdated,
          Value<DateTime?> lastCleared = const Value.absent()}) =>
      CacheChat(
        id: id ?? this.id,
        fromServer: fromServer ?? this.fromServer,
        contactId: contactId ?? this.contactId,
        contactFirstName: contactFirstName ?? this.contactFirstName,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        lastCleared: lastCleared.present ? lastCleared.value : this.lastCleared,
      );
  @override
  String toString() {
    return (StringBuffer('CacheChat(')
          ..write('id: $id, ')
          ..write('fromServer: $fromServer, ')
          ..write('contactId: $contactId, ')
          ..write('contactFirstName: $contactFirstName, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('lastCleared: $lastCleared')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, fromServer, contactId, contactFirstName, lastUpdated, lastCleared);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CacheChat &&
          other.id == this.id &&
          other.fromServer == this.fromServer &&
          other.contactId == this.contactId &&
          other.contactFirstName == this.contactFirstName &&
          other.lastUpdated == this.lastUpdated &&
          other.lastCleared == this.lastCleared);
}

class CacheChatsCompanion extends UpdateCompanion<CacheChat> {
  final Value<String> id;
  final Value<bool> fromServer;
  final Value<String> contactId;
  final Value<String> contactFirstName;
  final Value<DateTime> lastUpdated;
  final Value<DateTime?> lastCleared;
  const CacheChatsCompanion({
    this.id = const Value.absent(),
    this.fromServer = const Value.absent(),
    this.contactId = const Value.absent(),
    this.contactFirstName = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.lastCleared = const Value.absent(),
  });
  CacheChatsCompanion.insert({
    required String id,
    required bool fromServer,
    required String contactId,
    required String contactFirstName,
    required DateTime lastUpdated,
    this.lastCleared = const Value.absent(),
  })  : id = Value(id),
        fromServer = Value(fromServer),
        contactId = Value(contactId),
        contactFirstName = Value(contactFirstName),
        lastUpdated = Value(lastUpdated);
  static Insertable<CacheChat> custom({
    Expression<String>? id,
    Expression<bool>? fromServer,
    Expression<String>? contactId,
    Expression<String>? contactFirstName,
    Expression<DateTime>? lastUpdated,
    Expression<DateTime>? lastCleared,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromServer != null) 'from_server': fromServer,
      if (contactId != null) 'contact_id': contactId,
      if (contactFirstName != null) 'contact_first_name': contactFirstName,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (lastCleared != null) 'last_cleared': lastCleared,
    });
  }

  CacheChatsCompanion copyWith(
      {Value<String>? id,
      Value<bool>? fromServer,
      Value<String>? contactId,
      Value<String>? contactFirstName,
      Value<DateTime>? lastUpdated,
      Value<DateTime?>? lastCleared}) {
    return CacheChatsCompanion(
      id: id ?? this.id,
      fromServer: fromServer ?? this.fromServer,
      contactId: contactId ?? this.contactId,
      contactFirstName: contactFirstName ?? this.contactFirstName,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      lastCleared: lastCleared ?? this.lastCleared,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fromServer.present) {
      map['from_server'] = Variable<bool>(fromServer.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (contactFirstName.present) {
      map['contact_first_name'] = Variable<String>(contactFirstName.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (lastCleared.present) {
      map['last_cleared'] = Variable<DateTime>(lastCleared.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CacheChatsCompanion(')
          ..write('id: $id, ')
          ..write('fromServer: $fromServer, ')
          ..write('contactId: $contactId, ')
          ..write('contactFirstName: $contactFirstName, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('lastCleared: $lastCleared')
          ..write(')'))
        .toString();
  }
}

class $CacheChatsTable extends CacheChats
    with TableInfo<$CacheChatsTable, CacheChat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CacheChatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fromServerMeta =
      const VerificationMeta('fromServer');
  @override
  late final GeneratedColumn<bool> fromServer =
      GeneratedColumn<bool>('from_server', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("from_server" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _contactIdMeta =
      const VerificationMeta('contactId');
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
      'contact_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contactFirstNameMeta =
      const VerificationMeta('contactFirstName');
  @override
  late final GeneratedColumn<String> contactFirstName = GeneratedColumn<String>(
      'contact_first_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastClearedMeta =
      const VerificationMeta('lastCleared');
  @override
  late final GeneratedColumn<DateTime> lastCleared = GeneratedColumn<DateTime>(
      'last_cleared', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, fromServer, contactId, contactFirstName, lastUpdated, lastCleared];
  @override
  String get aliasedName => _alias ?? 'cache_chats';
  @override
  String get actualTableName => 'cache_chats';
  @override
  VerificationContext validateIntegrity(Insertable<CacheChat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('from_server')) {
      context.handle(
          _fromServerMeta,
          fromServer.isAcceptableOrUnknown(
              data['from_server']!, _fromServerMeta));
    } else if (isInserting) {
      context.missing(_fromServerMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(_contactIdMeta,
          contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta));
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    if (data.containsKey('contact_first_name')) {
      context.handle(
          _contactFirstNameMeta,
          contactFirstName.isAcceptableOrUnknown(
              data['contact_first_name']!, _contactFirstNameMeta));
    } else if (isInserting) {
      context.missing(_contactFirstNameMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    if (data.containsKey('last_cleared')) {
      context.handle(
          _lastClearedMeta,
          lastCleared.isAcceptableOrUnknown(
              data['last_cleared']!, _lastClearedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CacheChat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CacheChat(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      fromServer: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}from_server'])!,
      contactId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contact_id'])!,
      contactFirstName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}contact_first_name'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
      lastCleared: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_cleared']),
    );
  }

  @override
  $CacheChatsTable createAlias(String alias) {
    return $CacheChatsTable(attachedDatabase, alias);
  }
}

class CacheMessage extends DataClass implements Insertable<CacheMessage> {
  final String id;
  final bool fromServer;
  final String chat;
  final String userId;
  final String message;
  final DateTime sentTime;
  final DateTime lastUpdated;
  final bool deleted;
  const CacheMessage(
      {required this.id,
      required this.fromServer,
      required this.chat,
      required this.userId,
      required this.message,
      required this.sentTime,
      required this.lastUpdated,
      required this.deleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['from_server'] = Variable<bool>(fromServer);
    map['chat'] = Variable<String>(chat);
    map['user_id'] = Variable<String>(userId);
    map['message'] = Variable<String>(message);
    map['sent_time'] = Variable<DateTime>(sentTime);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    map['deleted'] = Variable<bool>(deleted);
    return map;
  }

  CacheMessagesCompanion toCompanion(bool nullToAbsent) {
    return CacheMessagesCompanion(
      id: Value(id),
      fromServer: Value(fromServer),
      chat: Value(chat),
      userId: Value(userId),
      message: Value(message),
      sentTime: Value(sentTime),
      lastUpdated: Value(lastUpdated),
      deleted: Value(deleted),
    );
  }

  factory CacheMessage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CacheMessage(
      id: serializer.fromJson<String>(json['id']),
      fromServer: serializer.fromJson<bool>(json['fromServer']),
      chat: serializer.fromJson<String>(json['chat']),
      userId: serializer.fromJson<String>(json['userId']),
      message: serializer.fromJson<String>(json['message']),
      sentTime: serializer.fromJson<DateTime>(json['sentTime']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
      deleted: serializer.fromJson<bool>(json['deleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fromServer': serializer.toJson<bool>(fromServer),
      'chat': serializer.toJson<String>(chat),
      'userId': serializer.toJson<String>(userId),
      'message': serializer.toJson<String>(message),
      'sentTime': serializer.toJson<DateTime>(sentTime),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'deleted': serializer.toJson<bool>(deleted),
    };
  }

  CacheMessage copyWith(
          {String? id,
          bool? fromServer,
          String? chat,
          String? userId,
          String? message,
          DateTime? sentTime,
          DateTime? lastUpdated,
          bool? deleted}) =>
      CacheMessage(
        id: id ?? this.id,
        fromServer: fromServer ?? this.fromServer,
        chat: chat ?? this.chat,
        userId: userId ?? this.userId,
        message: message ?? this.message,
        sentTime: sentTime ?? this.sentTime,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        deleted: deleted ?? this.deleted,
      );
  @override
  String toString() {
    return (StringBuffer('CacheMessage(')
          ..write('id: $id, ')
          ..write('fromServer: $fromServer, ')
          ..write('chat: $chat, ')
          ..write('userId: $userId, ')
          ..write('message: $message, ')
          ..write('sentTime: $sentTime, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, fromServer, chat, userId, message, sentTime, lastUpdated, deleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CacheMessage &&
          other.id == this.id &&
          other.fromServer == this.fromServer &&
          other.chat == this.chat &&
          other.userId == this.userId &&
          other.message == this.message &&
          other.sentTime == this.sentTime &&
          other.lastUpdated == this.lastUpdated &&
          other.deleted == this.deleted);
}

class CacheMessagesCompanion extends UpdateCompanion<CacheMessage> {
  final Value<String> id;
  final Value<bool> fromServer;
  final Value<String> chat;
  final Value<String> userId;
  final Value<String> message;
  final Value<DateTime> sentTime;
  final Value<DateTime> lastUpdated;
  final Value<bool> deleted;
  const CacheMessagesCompanion({
    this.id = const Value.absent(),
    this.fromServer = const Value.absent(),
    this.chat = const Value.absent(),
    this.userId = const Value.absent(),
    this.message = const Value.absent(),
    this.sentTime = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.deleted = const Value.absent(),
  });
  CacheMessagesCompanion.insert({
    required String id,
    required bool fromServer,
    required String chat,
    required String userId,
    required String message,
    required DateTime sentTime,
    required DateTime lastUpdated,
    required bool deleted,
  })  : id = Value(id),
        fromServer = Value(fromServer),
        chat = Value(chat),
        userId = Value(userId),
        message = Value(message),
        sentTime = Value(sentTime),
        lastUpdated = Value(lastUpdated),
        deleted = Value(deleted);
  static Insertable<CacheMessage> custom({
    Expression<String>? id,
    Expression<bool>? fromServer,
    Expression<String>? chat,
    Expression<String>? userId,
    Expression<String>? message,
    Expression<DateTime>? sentTime,
    Expression<DateTime>? lastUpdated,
    Expression<bool>? deleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromServer != null) 'from_server': fromServer,
      if (chat != null) 'chat': chat,
      if (userId != null) 'user_id': userId,
      if (message != null) 'message': message,
      if (sentTime != null) 'sent_time': sentTime,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (deleted != null) 'deleted': deleted,
    });
  }

  CacheMessagesCompanion copyWith(
      {Value<String>? id,
      Value<bool>? fromServer,
      Value<String>? chat,
      Value<String>? userId,
      Value<String>? message,
      Value<DateTime>? sentTime,
      Value<DateTime>? lastUpdated,
      Value<bool>? deleted}) {
    return CacheMessagesCompanion(
      id: id ?? this.id,
      fromServer: fromServer ?? this.fromServer,
      chat: chat ?? this.chat,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      sentTime: sentTime ?? this.sentTime,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      deleted: deleted ?? this.deleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fromServer.present) {
      map['from_server'] = Variable<bool>(fromServer.value);
    }
    if (chat.present) {
      map['chat'] = Variable<String>(chat.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (sentTime.present) {
      map['sent_time'] = Variable<DateTime>(sentTime.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CacheMessagesCompanion(')
          ..write('id: $id, ')
          ..write('fromServer: $fromServer, ')
          ..write('chat: $chat, ')
          ..write('userId: $userId, ')
          ..write('message: $message, ')
          ..write('sentTime: $sentTime, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }
}

class $CacheMessagesTable extends CacheMessages
    with TableInfo<$CacheMessagesTable, CacheMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CacheMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fromServerMeta =
      const VerificationMeta('fromServer');
  @override
  late final GeneratedColumn<bool> fromServer =
      GeneratedColumn<bool>('from_server', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("from_server" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _chatMeta = const VerificationMeta('chat');
  @override
  late final GeneratedColumn<String> chat = GeneratedColumn<String>(
      'chat', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES cache_chats (id)'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sentTimeMeta =
      const VerificationMeta('sentTime');
  @override
  late final GeneratedColumn<DateTime> sentTime = GeneratedColumn<DateTime>(
      'sent_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedMeta =
      const VerificationMeta('deleted');
  @override
  late final GeneratedColumn<bool> deleted =
      GeneratedColumn<bool>('deleted', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("deleted" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  @override
  List<GeneratedColumn> get $columns =>
      [id, fromServer, chat, userId, message, sentTime, lastUpdated, deleted];
  @override
  String get aliasedName => _alias ?? 'cache_messages';
  @override
  String get actualTableName => 'cache_messages';
  @override
  VerificationContext validateIntegrity(Insertable<CacheMessage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('from_server')) {
      context.handle(
          _fromServerMeta,
          fromServer.isAcceptableOrUnknown(
              data['from_server']!, _fromServerMeta));
    } else if (isInserting) {
      context.missing(_fromServerMeta);
    }
    if (data.containsKey('chat')) {
      context.handle(
          _chatMeta, chat.isAcceptableOrUnknown(data['chat']!, _chatMeta));
    } else if (isInserting) {
      context.missing(_chatMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('sent_time')) {
      context.handle(_sentTimeMeta,
          sentTime.isAcceptableOrUnknown(data['sent_time']!, _sentTimeMeta));
    } else if (isInserting) {
      context.missing(_sentTimeMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(_deletedMeta,
          deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta));
    } else if (isInserting) {
      context.missing(_deletedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, chat};
  @override
  CacheMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CacheMessage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      fromServer: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}from_server'])!,
      chat: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}chat'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      sentTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}sent_time'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
      deleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}deleted'])!,
    );
  }

  @override
  $CacheMessagesTable createAlias(String alias) {
    return $CacheMessagesTable(attachedDatabase, alias);
  }
}

abstract class _$LocalCacheClient extends GeneratedDatabase {
  _$LocalCacheClient(QueryExecutor e) : super(e);
  late final $CacheChatsTable cacheChats = $CacheChatsTable(this);
  late final $CacheMessagesTable cacheMessages = $CacheMessagesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [cacheChats, cacheMessages];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}
