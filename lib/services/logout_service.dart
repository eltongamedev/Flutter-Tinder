import 'package:firebase_auth/firebase_auth.dart';

abstract class LogoutServiceInterface {
  Future<void> logout();
}

class FirebaseLogoutService implements LogoutServiceInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> logout() async {
    await _auth.signOut();  // Faz o logout no Firebase Auth
  }
}