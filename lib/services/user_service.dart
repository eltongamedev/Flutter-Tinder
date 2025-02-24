import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore;

  UserService(this._firestore);

  Future<void> checkAndAddUser(UserModel user) async {
    DocumentReference userRef = _firestore.collection('users').doc(user.uid);
    DocumentSnapshot doc = await userRef.get();

    if (!doc.exists) {
      await userRef.set({
        'name': user.name,
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }
}

