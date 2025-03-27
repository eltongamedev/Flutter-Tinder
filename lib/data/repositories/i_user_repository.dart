abstract class IUserRepository {
  Future<void> updateUserData(String uid, Map<String, dynamic> data);
}