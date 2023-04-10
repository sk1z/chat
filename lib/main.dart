import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_login/app/app.dart';
import 'package:local_cache/local_cache.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepository();
  final localCache = LocalCacheClient();
  final firestoreRepository = FirestoreRepository(localChache: localCache);
  final user = await authenticationRepository.user.first;
  if (user.isNotEmpty) {
    await firestoreRepository.profile(user.id).first;
  }
  // BlocOverrides.runZoned(
  //   () =>
  runApp(
    App(
      authenticationRepository: authenticationRepository,
      localCache: localCache,
      firestoreRepository: firestoreRepository,
    ),
  )
      //   ,
      //   blocObserver: AppBlocObserver(),
      // )
      ;
}
