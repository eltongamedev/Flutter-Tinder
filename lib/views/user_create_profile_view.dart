import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder/views/teste.dart';
import '../viewmodels/login_viewmodel.dart';

class UserCreateProfileView extends StatefulWidget {
  const UserCreateProfileView({super.key});

  @override
  State<UserCreateProfileView> createState() => _UserCreateProfileViewState();
}

class _UserCreateProfileViewState extends State<UserCreateProfileView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tinder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await viewModel.logout();
              if (!mounted) return;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Teste()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          viewModel.user?.name ?? "Usuário não encontrado",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
