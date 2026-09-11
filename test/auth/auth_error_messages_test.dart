import 'package:coramdeo/widgets/auth_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthBottomSheet.getAuthErrorMessage translations', () {
    test('Translates invalid-credential and invalid_login_credentials', () {
      final err1 = FirebaseAuthException(code: 'invalid-credential');
      final err2 = FirebaseAuthException(code: 'invalid_login_credentials');

      expect(
        AuthBottomSheet.getAuthErrorMessage(err1),
        equals('E-mail ou senha incorretos.'),
      );
      expect(
        AuthBottomSheet.getAuthErrorMessage(err2),
        equals('E-mail ou senha incorretos.'),
      );
    });

    test('Translates user-not-found and wrong-password', () {
      final errUser = FirebaseAuthException(code: 'user-not-found');
      final errPass = FirebaseAuthException(code: 'wrong-password');

      expect(
        AuthBottomSheet.getAuthErrorMessage(errUser),
        equals('Nenhuma conta encontrada com este e-mail.'),
      );
      expect(
        AuthBottomSheet.getAuthErrorMessage(errPass),
        equals('Senha incorreta.'),
      );
    });

    test('Translates email-already-in-use and invalid-email', () {
      final errInUse = FirebaseAuthException(code: 'email-already-in-use');
      final errInvalid = FirebaseAuthException(code: 'invalid-email');

      expect(
        AuthBottomSheet.getAuthErrorMessage(errInUse),
        equals('Este e-mail já está cadastrado.'),
      );
      expect(
        AuthBottomSheet.getAuthErrorMessage(errInvalid),
        equals('Formato de e-mail inválido.'),
      );
    });

    test('Translates rate limiting and account status errors', () {
      final errDisabled = FirebaseAuthException(code: 'user-disabled');
      final errTooMany = FirebaseAuthException(code: 'too-many-requests');
      final errChannel = FirebaseAuthException(code: 'channel-error');

      expect(
        AuthBottomSheet.getAuthErrorMessage(errDisabled),
        equals('Esta conta foi desativada.'),
      );
      expect(
        AuthBottomSheet.getAuthErrorMessage(errTooMany),
        contains('Muitas tentativas consecutivas'),
      );
      expect(
        AuthBottomSheet.getAuthErrorMessage(errChannel),
        equals('Por favor, preencha todos os campos obrigatórios.'),
      );
    });

    test('Returns graceful fallback in Portuguese for unmapped auth errors', () {
      final errUnknown = FirebaseAuthException(code: 'some-new-unknown-code');
      expect(
        AuthBottomSheet.getAuthErrorMessage(errUnknown),
        equals('Ocorreu um erro ao processar a solicitação. Verifique os dados e tente novamente.'),
      );
    });

    test('Strips Exception: prefix from generic errors', () {
      final genericErr = Exception('Erro personalizado');
      expect(
        AuthBottomSheet.getAuthErrorMessage(genericErr),
        equals('Erro personalizado'),
      );
    });
  });
}
