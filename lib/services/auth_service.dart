import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _authService = FirebaseAuth.instance;

  // Método para obter o UID do usuário logado
  String? getCurrentUserUid() {
    final user = _authService.currentUser;
    return user?.uid; // Retorna o UID do usuário logado ou null
  }
}
