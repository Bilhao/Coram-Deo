import 'package:cloud_firestore/cloud_firestore.dart';
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
    try {
      await auth.setLanguageCode('pt-BR');
    } catch (_) {}
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

  /// Exclui permanentemente a conta do usuário e seus dados de backup na nuvem
  Future<void> deleteAccount() async {
    final user = currentUser;
    if (user == null) {
      throw Exception('Nenhum usuário conectado para excluir a conta.');
    }

    // 1. Exclui documentos de backup no Firestore
    try {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('backup')
          .doc('data');
      await docRef.delete();
    } catch (e) {
      debugPrint('Erro ao excluir dados do Firestore: $e');
    }

    // 2. Exclui conta do Firebase Auth
    try {
      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw Exception(
          'Por motivos de segurança, saia e faça login novamente antes de excluir sua conta.',
        );
      }
      rethrow;
    }

    // 3. Desconecta da conta Google se aplicável
    try {
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
    } catch (_) {}
  }
}

