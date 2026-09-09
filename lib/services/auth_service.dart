import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  FirebaseAuth? _auth;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  bool get isFirebaseInitialized {
    try {
      return Firebase.apps.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  FirebaseAuth get auth {
    _auth ??= FirebaseAuth.instance;
    return _auth!;
  }

  User? get currentUser {
    if (!isFirebaseInitialized) return null;
    try {
      return auth.currentUser;
    } catch (_) {
      return null;
    }
  }

  Stream<User?> get authStateChanges {
    if (!isFirebaseInitialized) {
      return Stream.value(null);
    }
    try {
      return auth.authStateChanges();
    } catch (_) {
      return Stream.value(null);
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (!isFirebaseInitialized) {
        throw Exception(
          'Firebase ainda não configurado. Por favor, adicione o arquivo google-services.json.',
        );
      }

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // Usuário cancelou a seleção da conta Google
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      debugPrint('Erro FirebaseAuth no Google Sign-In: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Erro geral no Google Sign-In: $e');
      rethrow;
    }
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    if (!isFirebaseInitialized) {
      throw Exception(
        'Firebase ainda não configurado. Por favor, adicione o arquivo google-services.json.',
      );
    }
    return await auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<UserCredential> signUpWithEmail(String email, String password) async {
    if (!isFirebaseInitialized) {
      throw Exception(
        'Firebase ainda não configurado. Por favor, adicione o arquivo google-services.json.',
      );
    }
    return await auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<void> sendPasswordReset(String email) async {
    if (!isFirebaseInitialized) {
      throw Exception(
        'Firebase ainda não configurado. Por favor, adicione o arquivo google-services.json.',
      );
    }
    await auth.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> signOut() async {
    try {
      if (isFirebaseInitialized) {
        await auth.signOut();
      }
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
    } catch (e) {
      debugPrint('Erro ao desconectar: $e');
    }
  }
}

