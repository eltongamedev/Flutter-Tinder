/// Interface que define um contrato para operações de atualização de dados do usuário.
abstract class IUserRepository {
  /// Cria documento do usuário se não existir
  Future<void> createUserDocument(String uid, Map<String, dynamic> initialData);
  
  /// Atualiza dados do usuário existente
  Future<void> updateUserData(String uid, Map<String, dynamic> data);
  
  /// Cria ou atualiza usuário em uma única operação
  Future<void> createOrUpdateUser(String uid, 
                               Map<String, dynamic> createData,
                               Map<String, dynamic> updateData);
}
