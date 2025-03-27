import 'package:flutter/material.dart';
import 'user_name_view_model.dart';

class UserProfileViewModel extends ChangeNotifier {
  final UserNameViewModel nameViewModel = UserNameViewModel();

  void saveUserProfile() {
    String name = nameViewModel.userName;

    print("Perfil salvo: $name");
  }

  @override
  void dispose() {
    nameViewModel.dispose();
    super.dispose();
  }
}
