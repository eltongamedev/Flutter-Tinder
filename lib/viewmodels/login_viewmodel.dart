import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';  // Importando a interface
import '../services/logout_service.dart';
import '../services/user_service.dart';  // Importando o UserService

class LoginViewModel extends ChangeNotifier {
  bool isLoading = false;
  UserModel? user;

  final LogoutServiceInterface _logoutService;
  final UserService _userService;

  // Injeção de dependência via construtor
  LoginViewModel({
    required LogoutServiceInterface logoutService,
    required UserService userService,
  })  : _logoutService = logoutService,
        _userService = userService;

  Future<void> login(AuthServiceInterface authService) async {
    isLoading = true;
    notifyListeners();

    // Tentando fazer o login com o serviço de autenticação
    user = await authService.signIn();

    if (user != null) {
      // Verifica e adiciona o usuário caso necessário
      await _userService.checkAndAddUser(user!);
    }

    isLoading = false;
    notifyListeners();
  }

  // Método de logout
  Future<void> logout() async {
    isLoading = true;
    notifyListeners();

    await _logoutService.logout();  // Chama o serviço de logout
    user = null;  // Remove o usuário logado

    isLoading = false;
    notifyListeners();
  }

  // Método para verificar se o usuário está logado
  bool get isLoggedIn => user != null;
}
