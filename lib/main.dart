import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder/services/user_service.dart';
import 'package:tinder/views/cadastro.page.dart';
import 'package:tinder/viewmodels/login_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/logout_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  final userService = UserService(FirebaseFirestore.instance);  // Use FirebaseFirestore.instance para obter a instância do Firestore

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(
            userService: userService,  // Injeção do UserService
            logoutService: FirebaseLogoutService(),  // Injeção de dependência
          ),
        ),
      ],
      child: MyApp(),
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
