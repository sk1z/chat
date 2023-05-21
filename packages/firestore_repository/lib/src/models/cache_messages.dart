import 'package:local_cache/local_cache.dart';

class CacheMessages {
  const CacheMessages(this.messages, this.fromServer);

  final List<CacheMessage> messages;
  final bool fromServer;
}
