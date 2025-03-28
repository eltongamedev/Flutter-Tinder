import 'package:flutter/material.dart';

class UserNameViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  String _userName = "";
  
  // Mantenha o valor sincronizado com o controller
  UserNameViewModel() {
    nameController.addListener(() {
      _userName = nameController.text;
      notifyListeners();
    });
  }
  
  String get userName => _userName;
  
  void setUserName(String name) {
    _userName = name;
    nameController.text = name; // Mantém o controller sincronizado
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}