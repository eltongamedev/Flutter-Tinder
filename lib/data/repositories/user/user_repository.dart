import 'package:cloud_firestore/cloud_firestore.dart';
import 'i_user_repository.dart';

class UserRepository implements IUserRepository {
  final FirebaseFirestore _firestore;

  UserRepository(this._firestore);

  @override
  Future<void> createUserDocument(String uid, Map<String, dynamic> initialData) async {
    try {
      final userDoc = _firestore.collection('users').doc(uid);
      final docSnapshot = await userDoc.get();
      
      if (!docSnapshot.exists) {
        await userDoc.set({
          ...initialData,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
        print('✅ Documento do usuário criado para UID: $uid');
      } else {
        print('ℹ️ Documento já existe para UID: $uid');
      }
    } catch (e) {
      print('❌ Erro ao criar documento: $e');
      throw Exception('Falha ao criar documento do usuário: $e');
    }
  }

  @override
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print('🔄 Dados atualizados para UID: $uid');
    } catch (e) {
      print('❌ Erro ao atualizar dados: $e');
      throw Exception('Falha ao atualizar dados do usuário: $e');
    }
  }

  @override
  Future<void> createOrUpdateUser(String uid, 
                               Map<String, dynamic> createData,
                               Map<String, dynamic> updateData) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        ...createData,
        ...updateData,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      print('✨ Dados criados/atualizados para UID: $uid');
    } catch (e) {
      print('❌ Erro em createOrUpdateUser: $e');
      throw Exception('Falha ao criar/atualizar usuário: $e');
    }
  }

  Future<void> saveUserName(String uid, String name) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      print('📝 Nome "$name" salvo para UID: $uid');
    } catch (e) {
      print('❌ Erro ao salvar nome: $e');
      throw Exception('Falha ao salvar nome do usuário: $e');
    }
  }
}