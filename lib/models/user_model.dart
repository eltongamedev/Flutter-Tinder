import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String? name;
  final String? email;
  final String? photoUrl;

  UserModel({
    required this.uid,
    this.name,
    this.email,
    this.photoUrl,
  });

  // Método para converter um objeto User do Firebase para UserModel
  factory UserModel.fromFirebase(User user) {
    return UserModel(
      uid: user.uid,
      name: user.displayName,
      email: user.email,
      photoUrl: user.photoURL,
    );
  }
}
