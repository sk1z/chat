import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:local_cache/local_cache.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit({
    required LocalCacheClient localCache,
    required FirestoreRepository firestoreRepository,
  })  : _localCache = localCache,
        _firestoreRepository = firestoreRepository,
        super(const ChatsState()) {
    _localCache.messagesLastFetchTimes().then((messagesLastFetchTimes) {
      _chatsSubscription = _localCache.watchChats().listen((chatList) {
        final chats = {for (final chat in chatList) chat.id: chat};
        emit(state.copyWith(chats: chats, chatList: chatList));
        for (final chat in chatList) {
          _messagesCachingSubscriptions[chat.id] ??= _firestoreRepository
              .messagesCaching(
                  chat.id, chat.lastCleared, messagesLastFetchTimes[chat.id])
              .listen((_) {});
        }
      });
    });
    _localCache.chatsLastFetchTime().then((chatsLastFetch) {
      _chatsCachingSubscription =
          _firestoreRepository.chatsCaching(chatsLastFetch).listen((_) {});
    });
  }

  final LocalCacheClient _localCache;
  final FirestoreRepository _firestoreRepository;
  StreamSubscription<List<ChatWithLastMessage>>? _chatsSubscription;
  StreamSubscription<void>? _chatsCachingSubscription;
  Map<String, StreamSubscription<void>> _messagesCachingSubscriptions = {};

  Future<void> clearChat(String chatId) async {
    return _firestoreRepository.clearChat(chatId);
  }

  @override
  Future<void> close() {
    _chatsSubscription?.cancel();
    _chatsCachingSubscription?.cancel();
    _messagesCachingSubscriptions.values
        .forEach((subscription) => subscription.cancel());
    return super.close();
  }
}
