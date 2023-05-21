import 'package:equatable/equatable.dart';

enum MessageSelectStatus { none, single, selected, unselected }

class Message extends Equatable {
  Message({
    required this.id,
    required this.isMy,
    required this.message,
    required this.lastUpdated,
    this.selectStatus = MessageSelectStatus.none,
  });

  final String id;
  final bool isMy;
  final String message;
  final DateTime lastUpdated;
  final MessageSelectStatus selectStatus;

  @override
  List<Object> get props => [id, isMy, message, lastUpdated, selectStatus];

  Message copyWith({
    MessageSelectStatus? selectStatus,
  }) =>
      Message(
        id: id,
        isMy: isMy,
        message: message,
        lastUpdated: lastUpdated,
        selectStatus: selectStatus ?? this.selectStatus,
      );
}
