import 'package:flutter/material.dart';
import '../models/user_profile/user_model.dart';
import '../services/auth_service_interface.dart';
import '../services/logout_service.dart';
import '../services/user_service.dart';
import '../data/repositories/user/user_repository.dart'; // Adicione esta importação
import 'package:cloud_firestore/cloud_firestore.dart'; // Adicione esta importação

class LoginViewModel extends ChangeNotifier {
  bool isLoading = false;
  UserModel? user;

  final LogoutServiceInterface _logoutService;
  final UserService _userService;
  final UserRepository _userRepository; // Adicione esta dependência

  LoginViewModel({
    required LogoutServiceInterface logoutService,
    required UserService userService,
    required UserRepository userRepository, // Adicione este parâmetro
  }) : _logoutService = logoutService,
       _userService = userService,
       _userRepository = userRepository;

  Future<void> login(AuthServiceInterface authService) async {
  try {
    isLoading = true;
    notifyListeners();

    user = await authService.signIn();
    
    if (user != null && user!.uid != null) {
      await _userRepository.createUserDocument(user!.uid!, {
        'email': user!.email,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'profileComplete': false, // Mantenha isso para controle de fluxo
      });
    }

    isLoading = false;
    notifyListeners();
  } catch (e) {
    isLoading = false;
    notifyListeners();
    rethrow;
  }
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