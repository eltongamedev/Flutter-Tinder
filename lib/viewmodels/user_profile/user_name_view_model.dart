import 'package:flutter/material.dart';

class UserNameViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();

  String _userName = "";
  String get userName => _userName;

  void setUserName(String name) {
    _userName = name;
    print("Nome atualizado no ViewModel: $name"); // Adicione esta linha
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
