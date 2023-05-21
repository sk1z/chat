import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chat/app/app.dart';
import 'package:local_cache/local_cache.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  final firestoreRepository = FirestoreRepository();
  final user = await authenticationRepository.user.first;
  if (user.isNotEmpty) {
    await firestoreRepository.profile(user.id).first;
  }
  final localCache = LocalCacheClient();

  await localCache.clearCache();
  await firestoreRepository.addExampleProfiles();

  runApp(App(
    authenticationRepository: authenticationRepository,
    firestoreRepository: firestoreRepository,
    localCache: localCache,
  ));
}
