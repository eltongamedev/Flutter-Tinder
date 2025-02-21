import 'package:flutter/material.dart';  // Importando o Flutter Material Design para construir a UI
import '../models/user_model.dart';  // Importando o modelo de dados do usuário (UserModel)

/// Interface para serviços de autenticação
abstract class AuthServiceInterface {
  Future<UserModel?> signIn();  // Método abstrato para o login, que será implementado pelos serviços de autenticação
}

/// ViewModel responsável pelo login
class LoginViewModel extends ChangeNotifier {
  bool isLoading = false;  // Controla se a tela de login está carregando (ex: para mostrar um spinner de carregamento)
  UserModel? user;  // Aqui é onde vamos armazenar os dados do usuário depois que ele logar

  // Método que realiza o login, recebendo um serviço de autenticação (que pode ser Google, Facebook, etc)
  Future<void> login(AuthServiceInterface authService) async {
    isLoading = true;  // Ativando o loading (spinner)
    notifyListeners();  // Notificando os ouvintes (UI) para atualizar a tela

    // Chama o método signIn do serviço de autenticação passado (Google, Facebook, etc) e armazena os dados do usuário
    user = await authService.signIn();

    isLoading = false;  // Desativando o loading
    notifyListeners();  // Notificando novamente para atualizar a tela
  }
}

/// Serviço de autenticação do Google
class GoogleAuthService implements AuthServiceInterface {
  final GoogleAuthService _googleauthService = GoogleAuthService();  // Criando uma instância da própria classe GoogleAuthService (Isso é um erro, vou comentar abaixo)

  @override
  Future<UserModel?> signIn() async {
    return await _googleauthService.signIn();  // Esse método apenas chama o método signIn da instância, mas o código está criando um loop infinito (isso é um erro)
  }
}
