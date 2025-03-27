import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserModel {
  final String uid;
  final String email;
  String? name;
  int? age;

  UserModel({
    required this.uid,
    required this.email,
    this.name,
    this.age,
  });

  // Método para pegar o UID e Email do Firebase sem forçar nome e idade
  factory UserModel.fromFirebase(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
    );
  }

  // Método para converter para Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'age': age,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}

