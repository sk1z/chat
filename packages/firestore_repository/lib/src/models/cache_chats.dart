import 'package:local_cache/local_cache.dart';

class CacheChats {
  const CacheChats(this.chats, this.fromServer);

  final List<CacheChat> chats;
  final bool fromServer;
}
