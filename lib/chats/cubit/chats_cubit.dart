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
  })  : _firestoreRepository = firestoreRepository,
        super(const ChatsState()) {
    localCache.userId = firestoreRepository.userId;

    localCache.messagesLastFetchTimes().then((lastFetchTimes) {
      _chatsSubscription = localCache.watchChats().listen((chatList) {
        final chats = {for (final chat in chatList) chat.id: chat};
        emit(state.copyWith(chats: chats, chatList: chatList));
        for (final chat in chatList) {
          _cacheMessagesSubscriptions[chat.id] ??= _firestoreRepository
              .cacheMessages(chat.id, chat.lastCleared, lastFetchTimes[chat.id])
              .listen((cacheMessages) {
            localCache.insertMessages(
                chat.id, cacheMessages.messages, cacheMessages.fromServer);
          });
        }
      });
    });
    localCache.chatsLastFetchTime().then((lastFetchTime) {
      _cacheChatsSubscription =
          _firestoreRepository.cacheChats(lastFetchTime).listen((cacheChats) {
        localCache.insertChats(cacheChats.chats, cacheChats.fromServer);
      });
    });
  }

  final FirestoreRepository _firestoreRepository;
  StreamSubscription<List<ChatWithLastMessage>>? _chatsSubscription;
  StreamSubscription<CacheChats>? _cacheChatsSubscription;
  final Map<String, StreamSubscription<CacheMessages>>
      _cacheMessagesSubscriptions = {};

  Future<void> clearChat(String chatId) async {
    return _firestoreRepository.clearChat(chatId);
  }

  @override
  Future<void> close() {
    _chatsSubscription?.cancel();
    _cacheChatsSubscription?.cancel();
    _cacheMessagesSubscriptions.values
        .forEach((subscription) => subscription.cancel());
    return super.close();
  }
}
