import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinder/views/cadastro.page.dart';
import 'firebase_options.dart';

// Services
import 'services/auth_service.dart';
import 'services/user_service.dart';
import 'services/logout_service.dart';

// Repositories
import 'data/repositories/user/user_repository.dart';

// ViewModels
import 'viewmodels/login_viewmodel.dart';
import 'viewmodels/profile_setup_viewmodel.dart';
import 'viewmodels/user_profile/user_name_view_model.dart';
import 'viewmodels/user_profile/user_profile_view_model.dart';

// Views
import 'views/profile_setup_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  final firestore = FirebaseFirestore.instance;
  final userRepository = UserRepository(firestore);
  final authService = AuthService();
  final userService = UserService(userRepository);  // Now correctly initialized

  runApp(
    MultiProvider(
      providers: [
        // Serviços e repositórios
        Provider<AuthService>(create: (_) => authService),
        Provider<UserRepository>(create: (_) => userRepository),
        
        // ViewModels
        ChangeNotifierProvider<UserNameViewModel>(
          create: (_) => UserNameViewModel(),
        ),
        
        ChangeNotifierProvider<ProfileSetupViewModel>(
          create: (_) => ProfileSetupViewModel(),
        ),
        
        ChangeNotifierProvider<UserProfileViewModel>(
          create: (context) => UserProfileViewModel(
            nameViewModel: context.read<UserNameViewModel>(),
            authService: context.read<AuthService>(),
            userRepository: context.read<UserRepository>(),
          ),
        ),

        ChangeNotifierProvider(create: (_) => ProfileSetupViewModel()),
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(
            userService: userService,
            logoutService: FirebaseLogoutService(),
            userRepository: UserRepository(firestore),
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
      title: 'Tinder Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CadastroPage(),
    );
  }
}