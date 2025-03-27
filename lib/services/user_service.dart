// services/user_service.dart
import '../data/repositories/i_user_repository.dart';
import '../models/user_profile/user_model.dart';

class UserService {
  final IUserRepository _userRepository;

  UserService(this._userRepository);

  Future<void> updateUserProfile(UserModel user) async {
    await _userRepository.updateUserData(user.uid, user.toMap());
  }
}