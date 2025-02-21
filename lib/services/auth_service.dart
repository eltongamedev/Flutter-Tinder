import '../models/user_model.dart';

/// Interface para serviços de autenticação
abstract class AuthServiceInterface {
  Future<UserModel?> signIn();
}
