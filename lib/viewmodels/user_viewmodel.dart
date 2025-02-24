import '../services/user_service.dart';
import '../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserViewModel {
  final UserService _userService;

  // Inicialize o UserService com FirebaseFirestore
  UserViewModel(FirebaseFirestore firestore)
      : _userService = UserService(firestore);

  Future<void> addUser(String name, String email, String uid) async {
    // Cria o UserModel
    UserModel user = UserModel(
      name: name,
      email: email,
      uid: uid,
    );

    // Chama o serviço para verificar e adicionar o usuário
    await _userService.checkAndAddUser(user);
  }
}
