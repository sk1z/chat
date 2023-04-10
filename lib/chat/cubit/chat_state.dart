part of 'chat_cubit.dart';

enum ChatMessageSelectStatus { none, single, multi }

class ChatState extends Equatable {
  ChatState({
    List<Message> messages = const [],
    String selectedMessageId = '',
    Set<String> selectedMessageIds = const {},
    String startMessageId = '',
    String endMessageId = '',
    Set<String> longPressMessageIds = const {},
    bool selectionEnded = false,
    required this.contactFirstName,
    this.messageHitPosition,
  }) {
    if (selectedMessageIds.isNotEmpty || longPressMessageIds.isNotEmpty) {
      int? startMessageIndex;
      int? endMessageIndex;
      if (startMessageId.isNotEmpty) {
        for (int i = 0; i < messages.length; i++) {
          if (messages[i].id == startMessageId) startMessageIndex = i;
          if (messages[i].id == endMessageId) endMessageIndex = i;
          if (startMessageIndex != null && endMessageIndex != null) break;
        }

        if (startMessageIndex == null || endMessageIndex == null) {
          final startIsFirst = startMessageId == longPressMessageIds.first;
          Set<String> ids = {};
          for (final message in messages) {
            if (longPressMessageIds.contains(message.id)) ids.add(message.id);
          }
          if (ids.isNotEmpty) {
            longPressMessageIds = ids;
            if (startMessageIndex == null) {
              startMessageId = startIsFirst
                  ? longPressMessageIds.first
                  : longPressMessageIds.last;
            }
            if (endMessageIndex == null) {
              endMessageId = startIsFirst
                  ? longPressMessageIds.last
                  : longPressMessageIds.first;
            }
          } else {
            startMessageId = '';
            endMessageId = '';
            startMessageIndex == null;
            endMessageIndex == null;
          }
        }
      }

      final selectedIds = <String>{};
      final longPressIds = <String>{};
      int messagesLength = 0;
      if (startMessageIndex != null) {
        final startIsFirst = startMessageIndex < endMessageIndex!;
        if (!startIsFirst) {
          final startMessage = endMessageIndex;
          endMessageIndex = startMessageIndex;
          startMessageIndex = startMessage;
        }
      }
      final messageList = <Message>[];
      for (int i = 0; i < messages.length; i++) {
        bool selected = false;
        if (selectedMessageIds.contains(messages[i].id)) {
          selected = true;
          selectedIds.add(messages[i].id);
        }
        if (startMessageIndex != null &&
            i >= startMessageIndex &&
            i <= endMessageIndex!) {
          if (!selectionEnded) {
            selected = true;
            longPressIds.add(messages[i].id);
          } else if (!selected) {
            selected = true;
            selectedIds.add(messages[i].id);
          }
        }
        if (selected) {
          messagesLength++;
          messageList.add(
              messages[i].copyWith(selectStatus: MessageSelectStatus.selected));
        } else {
          messageList.add(messages[i]
              .copyWith(selectStatus: MessageSelectStatus.unselected));
        }
      }
      this.messages = messageList;
      selectStatus = messagesLength > 0
          ? ChatMessageSelectStatus.multi
          : ChatMessageSelectStatus.none;
      this.selectedMessageId = '';
      this.selectedMessageIds = selectedIds;
      if (selectionEnded) {
        longPressStartMessageId = '';
        longPressEndMessageId = '';
      } else {
        longPressStartMessageId = startMessageId;
        longPressEndMessageId = endMessageId;
      }
      this.longPressMessageIds = longPressIds;
      selectedMessagesLength = messagesLength;
    } else if (selectedMessageId.isNotEmpty) {
      bool messageFound = false;
      this.messages = messages.map((message) {
        final selected = message.id == selectedMessageId;
        if (selected) messageFound = true;
        final selectStatus =
            selected ? MessageSelectStatus.single : MessageSelectStatus.none;
        return message.copyWith(selectStatus: selectStatus);
      }).toList();
      if (messageFound) {
        this.selectedMessageId = selectedMessageId;
        selectStatus = ChatMessageSelectStatus.single;
      } else {
        this.selectedMessageId = '';
        selectStatus = ChatMessageSelectStatus.none;
      }
      this.selectedMessageIds = const {};
      longPressStartMessageId = '';
      longPressEndMessageId = '';
      this.longPressMessageIds = const {};
      selectedMessagesLength = 0;
    } else {
      this.messages = messages.map((message) {
        return message.copyWith(selectStatus: MessageSelectStatus.unselected);
      }).toList();
      this.selectedMessageId = '';
      this.selectedMessageIds = const {};
      longPressStartMessageId = '';
      longPressEndMessageId = '';
      this.longPressMessageIds = const {};
      selectedMessagesLength = 0;
      selectStatus = ChatMessageSelectStatus.none;
    }
  }

  late final List<Message> messages;
  late final String selectedMessageId;
  late final Set<String> selectedMessageIds;
  late final String longPressStartMessageId;
  late final String longPressEndMessageId;
  late final Set<String> longPressMessageIds;
  late final int selectedMessagesLength;
  late final ChatMessageSelectStatus selectStatus;
  final String contactFirstName;
  final Offset? messageHitPosition;

  @override
  List<Object> get props => [messages, longPressStartMessageId];

  ChatState copyWith({
    List<Message>? messages,
    String? selectedMessageId,
    Set<String>? selectedMessageIds,
    String? longPressStartMessageId,
    String? longPressEndMessageId,
    Set<String>? longPressMessageIds,
    bool? longPressSelectionEnded,
    Offset? messageHitPosition,
  }) =>
      ChatState(
        messages: messages ?? this.messages,
        selectedMessageId: selectedMessageId ?? this.selectedMessageId,
        selectedMessageIds: selectedMessageIds ?? this.selectedMessageIds,
        startMessageId: longPressStartMessageId ?? this.longPressStartMessageId,
        endMessageId: longPressEndMessageId ?? this.longPressEndMessageId,
        longPressMessageIds: longPressMessageIds ?? this.longPressMessageIds,
        selectionEnded: longPressSelectionEnded ?? false,
        contactFirstName: contactFirstName,
        messageHitPosition: messageHitPosition,
      );
}
