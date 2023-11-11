import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendOTP(
      String phoneNumber,
      Function(String verificationId) onCodeSent,
      Function(FirebaseAuthException) onVerificationFailed) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: onVerificationFailed,
        codeSent: (String verificationId, int? resendToken) {
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print('Error sending OTP: $e');
    }
  }

  void verifyOTP(
      String verificationId,
      String otp,
      Function() onVerificationSuccess,
      Function(FirebaseAuthException) onVerificationFailed) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        onVerificationSuccess();
      } else {
        onVerificationFailed(FirebaseAuthException(
            code: 'verification_failed', message: 'Invalid OTP'));
      }
    } catch (e) {
      onVerificationFailed(FirebaseAuthException(
          code: 'verification_error', message: 'Error verifying OTP: $e'));
    }
  }
}
