part of 'chats_cubit.dart';

class ChatsState extends Equatable {
  const ChatsState({
    this.chats = const {},
    this.chatList = const [],
  });

  final Map<String, ChatWithLastMessage> chats;
  final List<ChatWithLastMessage> chatList;

  @override
  List<Object> get props => [chats, chatList];

  ChatsState copyWith({
    Map<String, ChatWithLastMessage>? chats,
    List<ChatWithLastMessage>? chatList,
  }) =>
      ChatsState(
        chats: chats ?? this.chats,
        chatList: chatList ?? this.chatList,
      );
}
