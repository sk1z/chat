import 'dart:async';

import 'package:flutter/widgets.dart';

import 'message_selection_hit_tester.dart';
import 'message_selection_types.dart';

const Duration _scrollJumpFrequency = Duration(milliseconds: 1);
const int _scrollJumpOffset = 1;

class MessageSelectionController extends StatefulWidget {
  const MessageSelectionController({
    super.key,
    required this.builder,
    this.onSelectionStart,
    this.onSelectionUpdate,
    this.onSelectionEnd,
  });

  final MessageSelectionWidgetBuilder builder;
  final MessageSelectionActionCallback? onSelectionStart;
  final MessageSelectionActionCallback? onSelectionUpdate;
  final MessageSelectionActionCallback? onSelectionEnd;

  @override
  State<MessageSelectionController> createState() =>
      _MessageSelectionControllerrState();
}

class _MessageSelectionControllerrState
    extends State<MessageSelectionController> {
  final _scrollController = ScrollController();
  ScrollStatus _scrollStatus = ScrollStatus.still;
  Offset? _localHitPosition;
  Offset? _globalHitPosition;
  Timer? _scrollJumpTimer;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollStatus == ScrollStatus.still ||
          _localHitPosition == null ||
          _globalHitPosition == null) return;
      final hitData = _hitTestAt(_localHitPosition!, _globalHitPosition!);
      _updateSelection(hitData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MessageSelectionHitTester(
      child: LayoutBuilder(builder: (context, constraints) {
        return GestureDetector(
          onLongPressStart: _onLongPressStart,
          onLongPressMoveUpdate: (details) =>
              _onLongPressMoveUpdate(details, constraints),
          onLongPressEnd: _onLongPressEnd,
          child: widget.builder(context, _scrollController),
        );
      }),
    );
  }

  void _onLongPressStart(LongPressStartDetails details) {
    _localHitPosition = details.localPosition;
    _globalHitPosition = details.globalPosition;
    final hitData = _hitTestAt(details.localPosition, details.globalPosition);
    _startSelection(hitData);
  }

  void _onLongPressMoveUpdate(
      LongPressMoveUpdateDetails details, BoxConstraints constraints) {
    _localHitPosition = details.localPosition;
    _globalHitPosition = details.globalPosition;
    final hitData = _hitTestAt(details.localPosition, details.globalPosition);
    _updateSelection(hitData);
    final scrollStatus = details.localPosition.dy < 90
        ? ScrollStatus.up
        : details.localPosition.dy > constraints.maxHeight - 90
            ? ScrollStatus.down
            : ScrollStatus.still;
    if (scrollStatus == _scrollStatus) return;
    _scrollStatus = scrollStatus;
    if (scrollStatus == ScrollStatus.still) return;
    _scrollJumpTimer = Timer.periodic(_scrollJumpFrequency, (timer) {
      if (!_scrollController.hasClients) {
      } else if (_scrollStatus == ScrollStatus.up &&
          _scrollController.offset > 0) {
        return _scrollController.jumpTo(
            _scrollController.offset < _scrollJumpOffset
                ? 0
                : _scrollController.offset - _scrollJumpOffset);
      } else if (_scrollStatus == ScrollStatus.down &&
          _scrollController.offset <
              _scrollController.position.maxScrollExtent) {
        return _scrollController.jumpTo(_scrollController.offset >
                _scrollController.position.maxScrollExtent - _scrollJumpOffset
            ? _scrollController.position.maxScrollExtent
            : _scrollController.offset + _scrollJumpOffset);
      }
      timer.cancel();
    });
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    _scrollStatus = ScrollStatus.still;
    final hitData = _hitTestAt(details.localPosition, details.globalPosition);
    _endSelection(hitData);
  }

  MessageHitData? _hitTestAt(Offset localPosition, Offset globalPosition) {
    final RenderMessageSelectionHitTester? hitTester =
        context.findRenderObject() as RenderMessageSelectionHitTester?;
    return hitTester?.hitTestAt(localPosition, globalPosition);
  }

  void _startSelection(MessageHitData? hitData) {
    if (hitData == null) return;
    widget.onSelectionStart?.call(hitData.messageId, hitData.hitPosition);
  }

  void _updateSelection(MessageHitData? hitData) {
    if (hitData == null) return;
    widget.onSelectionUpdate?.call(hitData.messageId, hitData.hitPosition);
  }

  void _endSelection(MessageHitData? hitData) {
    if (hitData == null) return;
    widget.onSelectionEnd?.call(hitData.messageId, hitData.hitPosition);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollJumpTimer?.cancel();
    super.dispose();
  }
}
