import 'package:flutter/material.dart';
import 'user_name_view_model.dart';
import '../../services/auth_service.dart'; 
import '../../data/repositories/user/user_repository.dart';

class UserProfileViewModel extends ChangeNotifier {
  UserNameViewModel nameViewModel; // Removido 'final' para permitir atualização
  final AuthService _authService;
  final UserRepository _userRepository;

  UserProfileViewModel({
    required this.nameViewModel, // Agora pode ser atualizado
    required AuthService authService,
    required UserRepository userRepository,
  })  : _authService = authService,
        _userRepository = userRepository;

  // Método para atualizar a viewmodel filha
  void updateNameViewModel(UserNameViewModel newViewModel) {
    nameViewModel = newViewModel;
    notifyListeners();
  }

  Future<void> saveUserProfile() async {
    print("Nome a ser salvo: ${nameViewModel.userName}");
    final uid = _authService.getCurrentUserUid();
    if (uid != null) {
      await _userRepository.updateUserData(uid, {'name': nameViewModel.userName});
    }
  }

  @override
  void dispose() {
    nameViewModel.dispose();
    super.dispose();
  }
}