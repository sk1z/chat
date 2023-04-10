import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

enum _ProviderType { password, google }

/// {@template sign_up_with_email_and_password_failure}
/// Thrown if during the sign up process if a failure occurs.
/// {@endtemplate}
class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_email_and_password_failure}
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
/// {@endtemplate}
class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_google_failure}
/// Thrown during the sign in with google process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
/// {@endtemplate}
class LogInWithGoogleFailure implements Exception {
  /// {@macro log_in_with_google_failure}
  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed. Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

class EmailUpdateFailure implements Exception {
  const EmailUpdateFailure([
    this.message = 'An unknown exception occurred.',
    this.recentLoginRequired = false,
  ]);

  factory EmailUpdateFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const EmailUpdateFailure(
          'Email is not valid or badly formatted.',
        );
      case 'email-already-in-use':
        return const EmailUpdateFailure(
          'An account already exists for that email.',
        );
      case 'requires-recent-login':
        return const EmailUpdateFailure(
          'You must be reauthenticate to update your email.',
          true,
        );
      default:
        return const EmailUpdateFailure();
    }
  }

  final String message;
  final bool recentLoginRequired;
}

class PasswordUpdateFailure implements Exception {
  const PasswordUpdateFailure([
    this.message = 'An unknown exception occurred.',
    this.recentLoginRequired = false,
  ]);

  factory PasswordUpdateFailure.fromCode(String code) {
    switch (code) {
      case 'weak-password':
        return const PasswordUpdateFailure(
          'Please enter a stronger password.',
        );
      case 'requires-recent-login':
        return const PasswordUpdateFailure(
          'You must be reauthenticate to update your password.',
          true,
        );
      default:
        return const PasswordUpdateFailure();
    }
  }

  final String message;
  final bool recentLoginRequired;
}

class ReauthenticationFailure implements Exception {
  const ReauthenticationFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  static const googleAccountMismatched = const ReauthenticationFailure(
    'Google account does not correspond to the user.',
  );

  factory ReauthenticationFailure.fromCode(
      String code, _ProviderType provider) {
    switch (code) {
      case 'user-mismatch':
        switch (provider) {
          case _ProviderType.password:
            return const ReauthenticationFailure(
              'Email does not correspond to the user.',
            );
          case _ProviderType.google:
            return googleAccountMismatched;
        }
      case 'user-not-found':
        switch (provider) {
          case _ProviderType.password:
            return const ReauthenticationFailure(
              'Email does not correspond to any existing user.',
            );
          case _ProviderType.google:
            return const ReauthenticationFailure(
              'Google account does not correspond to any existing user.',
            );
        }
      case 'invalid-credential':
        return const ReauthenticationFailure(
          'Provider\'s credential is not valid.',
        );
      case 'invalid-email':
        return const ReauthenticationFailure(
          'Email is not valid or badly formatted.',
        );
      case 'wrong-password':
        return const ReauthenticationFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const ReauthenticationFailure(
          'Verification code is not valid.',
        );
      case 'invalid-verification-id':
        return const ReauthenticationFailure(
          'Verification ID is not valid.',
        );
      default:
        return const ReauthenticationFailure();
    }
  }

  final String message;
}

class LinkWithCredentialFailure implements Exception {
  const LinkWithCredentialFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LinkWithCredentialFailure.fromCode(String code) {
    switch (code) {
      case 'provider-already-linked':
        return const LinkWithCredentialFailure(
          'Google account has already been linked.',
        );
      case 'invalid-credential':
        return const LinkWithCredentialFailure(
          'Google account is not valid.',
        );
      case 'credential-already-in-use':
        return const LinkWithCredentialFailure(
          'Google account is already linked to a another user.',
        );
      case 'email-already-in-use':
        return const LinkWithCredentialFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const LinkWithCredentialFailure(
          'Provider is not enabled.',
        );
      case 'invalid-email':
        return const LinkWithCredentialFailure(
          'Email is not valid or password is not correct.',
        );
      case 'invalid-verification-code':
        return const LinkWithCredentialFailure(
          'Verification code is not valid.',
        );
      case 'invalid-verification-id':
        return const LinkWithCredentialFailure(
          'Verification ID is not valid.',
        );
      default:
        return const LinkWithCredentialFailure();
    }
  }

  final String message;
}

class UnlinkFailure implements Exception {
  const UnlinkFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory UnlinkFailure.fromCode(String code, _ProviderType provider) {
    switch (code) {
      case 'no-such-provider':
        switch (provider) {
          case _ProviderType.password:
            return const UnlinkFailure(
              'Password not set.',
            );

          case _ProviderType.google:
            return const UnlinkFailure(
              'Google not linked.',
            );
        }

      default:
        return const UnlinkFailure();
    }
  }

  final String message;
}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  /// Whether or not the current environment is web
  /// Should only be overriden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth
        .
        //  authStateChanges()
        userChanges()
        .map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);

      return user;
    });
  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;
      if (isWeb) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }

  Future<void> updateEmail({required String email}) async {
    try {
      await _firebaseAuth.currentUser?.updateEmail(email);
    } on FirebaseAuthException catch (e) {
      throw EmailUpdateFailure.fromCode(e.code);
    } catch (_) {
      throw const EmailUpdateFailure();
    }
  }

  Future<void> updatePassword({required String password}) async {
    try {
      await _firebaseAuth.currentUser?.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      throw PasswordUpdateFailure.fromCode(e.code);
    } catch (_) {
      throw const PasswordUpdateFailure();
    }
  }

  Future<bool> reauthenticateWithGoogle() async {
    await _googleSignIn.signOut();
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return false;
    }
    if (googleUser.id != currentUser.googleProvider?.id) {
      throw ReauthenticationFailure.googleAccountMismatched;
    }
    try {
      final googleAuth = await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.currentUser?.reauthenticateWithCredential(credential);
      return true;
    } on FirebaseAuthException catch (e) {
      throw ReauthenticationFailure.fromCode(e.code, _ProviderType.google);
    } catch (_) {
      throw const ReauthenticationFailure();
    }
  }

  Future<void> reauthenticateWithPassword({required String password}) async {
    try {
      final credential = firebase_auth.EmailAuthProvider.credential(
        email: currentUser.email!,
        password: password,
      );
      await _firebaseAuth.currentUser?.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw ReauthenticationFailure.fromCode(e.code, _ProviderType.password);
    } catch (_) {
      throw const ReauthenticationFailure();
    }
  }

  Future<void> removePassword() async {
    try {
      await _firebaseAuth.currentUser?.unlink('password');
    } on FirebaseAuthException catch (e) {
      throw UnlinkFailure.fromCode(e.code, _ProviderType.password);
    } catch (_) {
      throw const UnlinkFailure();
    }
  }

  Future<void> linkGoogle() async {
    try {
      await _googleSignIn.signOut();
      final googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _firebaseAuth.currentUser?.linkWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      throw LinkWithCredentialFailure.fromCode(e.code);
    } catch (_) {
      throw const LinkWithCredentialFailure();
    }
  }

  Future<void> unlinkGoogle() async {
    try {
      await _firebaseAuth.currentUser?.unlink('google.com');
    } on FirebaseAuthException catch (e) {
      throw UnlinkFailure.fromCode(e.code, _ProviderType.google);
    } catch (_) {
      throw const UnlinkFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    final providers = Map.fromEntries(providerData.map((provider) => MapEntry(
          provider.providerId,
          Provider(
            id: provider.uid,
            email: provider.email,
            phoneNumber: provider.phoneNumber,
            name: provider.displayName,
            photo: provider.photoURL,
          ),
        )));

    return User(
      id: uid,
      email: email,
      name: displayName,
      photo: photoURL,
      googleProvider: providers['google.com'],
      passwordProvider: providers['password'],
    );
  }
}
