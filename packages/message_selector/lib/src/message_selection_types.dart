import 'package:flutter/widgets.dart';

enum ScrollStatus { still, up, down }

class MessageHitData {
  const MessageHitData(this.messageId, this.hitPosition);
  final String messageId;
  final Offset hitPosition;
}

typedef MessageSelectionActionCallback = void Function(
    String messageId, Offset hitPosition);

typedef MessageSelectionWidgetBuilder = Widget Function(
    BuildContext context, ScrollController scrollController);

class MessageSelectionMetaData {
  const MessageSelectionMetaData({required this.messageId});
  final String messageId;
}
