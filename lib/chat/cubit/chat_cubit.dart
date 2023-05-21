import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:chat/chat/chat.dart';
import 'package:chat/chats/chats.dart';
import 'package:local_cache/local_cache.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required String contactId,
    required LocalCacheClient localCache,
    required ChatsCubit chatsCubit,
    required FirestoreRepository firestoreUserRepository,
    required String contactFirstName,
  })  : _contactId = contactId,
        _localCache = localCache,
        _chatsCubit = chatsCubit,
        _firestoreRepository = firestoreUserRepository,
        super(ChatState(contactFirstName: contactFirstName)) {
    final userId = _firestoreRepository.userId;
    _chatId = userId.compareTo(_contactId).isNegative
        ? '$userId\_$contactId'
        : '$_contactId\_$userId';
    _messagesSubscription =
        _localCache.watchMessages(_chatId).listen((cacheMessages) {
      final messages = cacheMessages.map((message) {
        return Message(
          id: message.id,
          isMy: message.senderId == userId,
          message: message.message,
          lastUpdated: message.lastUpdated,
        );
      }).toList();
      emit(state.copyWith(messages: messages));
    });
  }

  final String _contactId;
  late final String _chatId;
  final LocalCacheClient _localCache;
  late final StreamSubscription<List<CacheMessage>> _messagesSubscription;
  final FirestoreRepository _firestoreRepository;
  final ChatsCubit _chatsCubit;

  void messageSelected(String messageId, Offset hitPosition) {
    final selectedMessagesLength = state.selectedMessagesLength;
    if (selectedMessagesLength > 0) {
      final selectedMessageIds = state.selectedMessageIds.toSet();
      final messageSelected = selectedMessageIds.contains(messageId);
      if (messageSelected) {
        selectedMessageIds.removeWhere((id) {
          return id == messageId;
        });
      } else {
        selectedMessageIds.add(messageId);
      }
      emit(state.copyWith(
        selectedMessageIds: selectedMessageIds,
        messageHitPosition: hitPosition,
      ));
    } else {
      emit(state.copyWith(
        selectedMessageId: messageId,
        messageHitPosition: hitPosition,
      ));
    }
  }

  void longPressSelectionStarted(String messageId, Offset hitPosition) {
    emit(state.copyWith(
      longPressStartMessageId: messageId,
      longPressEndMessageId: messageId,
      longPressMessageIds: {messageId},
      messageHitPosition: hitPosition,
    ));
  }

  void longPressSelectionUpdated(String endMessageId, Offset hitPosition) {
    final longPressEndMessageId = state.longPressEndMessageId;
    if (endMessageId == longPressEndMessageId) return;
    emit(state.copyWith(
      longPressEndMessageId: endMessageId,
      messageHitPosition: hitPosition,
    ));
  }

  void longPressSelectionEnded(String endMessageId, Offset hitPosition) {
    emit(state.copyWith(
      longPressEndMessageId: endMessageId,
      longPressSelectionEnded: true,
      messageHitPosition: hitPosition,
    ));
  }

  void messagesDeselected() {
    emit(state.copyWith(
      selectedMessageId: '',
      selectedMessageIds: const {},
      longPressStartMessageId: '',
      longPressEndMessageId: '',
      longPressMessageIds: const {},
    ));
  }

  void addMessage(String message) {
    _firestoreRepository.addMessage(
        chatExists: _chatsCubit.state.chats[_chatId] != null,
        chatId: _chatId,
        contactId: _contactId,
        contactFirstName: state.contactFirstName,
        message: message);
  }

  void deleteMessage() {
    final messageId = state.selectedMessageId;
    if (messageId.isEmpty) return;
    _firestoreRepository.deleteMessage(_chatId, messageId);
  }

  void deleteMessages() {
    final messageIds = state.selectedMessageIds.toList();
    if (messageIds.isEmpty) return;
    _firestoreRepository.deleteMessages(_chatId, messageIds);
  }

  @override
  Future<void> close() {
    _messagesSubscription.cancel();
    return super.close();
  }

  void addExampleMessages() {
    _firestoreRepository.addExampleMessages(
        _chatId, _firestoreRepository.userId, _contactId);
  }
}
