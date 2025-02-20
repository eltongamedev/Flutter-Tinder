import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool isLoading = false;
  UserModel? user;

  Future<void> loginWithGoogle() async {
    isLoading = true;
    notifyListeners(); // Atualiza a UI

    user = await _authService.signInWithGoogle();

    isLoading = false;
    notifyListeners();
  }
}
