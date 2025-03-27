import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder/services/user_service.dart';
import 'package:tinder/views/cadastro.page.dart';
import 'package:tinder/viewmodels/login_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tinder/views/profile_setup_view.dart';
import 'firebase_options.dart';
import 'services/logout_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../viewmodels/user_profile/user_name_view_model.dart';
import '../viewmodels/profile_setup_viewmodel.dart';

import 'data/repositories/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  final firestore = FirebaseFirestore.instance;
  final userRepository = UserRepository(firestore); // Initialize UserRepository
  final userService = UserService(userRepository);  // Now correctly initialized

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserNameViewModel>(create: (_) => UserNameViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileSetupViewModel()),
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(
            userService: userService,
            logoutService: FirebaseLogoutService(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const CadastroPage(),
    );
  }
}
