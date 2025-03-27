import 'package:flutter/material.dart';
import '../models/user_profile/user_model.dart';
import '../services/auth_service.dart'; // Importando a interface
import '../services/logout_service.dart';
import '../services/user_service.dart'; // Importando o UserService

class LoginViewModel extends ChangeNotifier {
  bool isLoading = false;
  UserModel? user;

  final LogoutServiceInterface _logoutService;
  final UserService _userService; // ← Novo campo

  LoginViewModel({
    required LogoutServiceInterface logoutService,
    required UserService userService, // ← Novo parâmetro
  }) : _logoutService = logoutService,
       _userService = userService;

  Future<void> login(AuthServiceInterface authService) async {
    isLoading = true;
    notifyListeners();

    // Pegando o usuário do serviço de autenticação
    user = await authService.signIn(); // Agora o retorno é um UserModel

    isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    isLoading = true;
    notifyListeners();

    await _logoutService.logout();
    user = null;

    isLoading = false;
    notifyListeners();
  }

  bool get isLoggedIn => user != null;
}
